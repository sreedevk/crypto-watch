class Reports
  def self.monthly_report(opts)
    conversion_medium = opts[:conversion_medium]
    report = CurrencyHistory.monthly_report(opts[:currency_id])
    report_book = Spreadsheet::Workbook.new
    report_sheet = report_book.create_worksheet
    report_sheet.name = "#{report.first.currency.name} Report"
    report_sheet.row(0).concat %w{Time Value CirculatingSupply Change(1h) Change(24h) Change(1w) MarketCapital Volume(24h)}
    report.each_with_index do |report_row, index|
      index += 1
      report_sheet[index, 0] = self.format_time(report_row.created_at).join(" - ")
      report_sheet[index, 1] = report_row.send(self.current_price(conversion_medium))&.round(2)
      report_sheet[index, 2] = report_row.send("circulating_supply")
      report_sheet[index, 3] = report_row.send("perc_change_1h_#{conversion_medium}")
      report_sheet[index, 4] = report_row.send("perc_change_24h_#{conversion_medium}")
      report_sheet[index, 5] = report_row.send("perc_change_7d_#{conversion_medium}")
      report_sheet[index, 6] = report_row.send("market_cap_#{conversion_medium}")
      report_sheet[index, 7] = report_row.send("volume_24h_#{conversion_medium}")
    end
    file_name = "#{report.first.currency.name}_#{DateTime.now.to_i}.xlsx"
    file_path = File.join(Rails.root, "public", "reports", file_name)
    report_book.write(file_path)
    return file_name
  end

  def self.format_time(time)
    date = time.strftime("%d/%m/%Y")
    time = time.strftime("%I:%M%p");
    return date, time
  end

  def self.current_price(conversion_medium)
    conversion_medium.downcase == "usd" ? "current_price" : "price_#{conversion_medium.downcase}"
  end
end
