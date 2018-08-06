RSpec::Matchers.define :have_table_row do |number:, values:|
  match do |page|
    row = page.find("tr:nth-child(#{number})")

    expect(row.all("td").map(&:text)).to eq(values)
  end
end
