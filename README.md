# fiscally

[![Gem Version](https://badge.fury.io/rb/fiscally.svg)](https://rubygems.org/gems/fiscally)
[![Build Status](https://travis-ci.org/forgecrafted/fiscally.svg?branch=master)](https://travis-ci.org/forgecrafted/fiscally)
[![Coverage Status](https://coveralls.io/repos/forgecrafted/fiscally/badge.svg?branch=master)](https://coveralls.io/r/forgecrafted/fiscally?branch=master)

Projects with a financial or business bent often have to deal with awareness of a fiscal year, which typically doesn't line up with a normal calendar year.

The `Fiscally` gem adds the necessary awareness to your date and time objects, covering start and end dates for fiscal years and quarterly breakdowns.

## Installation

Gemfile
```
gem 'fiscally'
```

Command line
```
gem install 'fiscally'
```

### Ruby Version

Built and tested against **`2.0.0` and above**, but Probably Works&trade; in `1.9.3`.

## Usage

All calculations are done **relative to the date and/or time represented by your object**. This is particularly important to remember for methods that calculate a "current" value. Our documentation examples use dates in the past to drive this point home.

Time is always set to midnight (`00:00:00`), when applicable.

Examples below use `Time`, but all methods outlined are available to `Date` and `DateTime` objects as well.

  - [`#fiscal_start=`](https://github.com/forgecrafted/fiscally#fiscal_start) :boom:
  - [`#fiscal_quarter`](https://github.com/forgecrafted/fiscally#fiscal_quarter)
  - [`#all_quarter_months`](https://github.com/forgecrafted/fiscally#all_quarter_months)
  - [`#fiscal_quarter_months`](https://github.com/forgecrafted/fiscally#fiscal_quarter_months)
  - [`#first_month_of_quarter`](https://github.com/forgecrafted/fiscally#first_month_of_quarter)
  - [`#first_quarter`](https://github.com/forgecrafted/fiscally#first_quarter)
  - [`#second_quarter`](https://github.com/forgecrafted/fiscally#second_quarter)
  - [`#third_quarter`](https://github.com/forgecrafted/fiscally#third_quarter)
  - [`#fourth_quarter`](https://github.com/forgecrafted/fiscally#fourth_quarter)
  - [`#beginning_of_fiscal_year`](https://github.com/forgecrafted/fiscally#beginning_of_fiscal_year)
  - [`#beginning_of_fiscal_quarter`](https://github.com/forgecrafted/fiscally#beginning_of_fiscal_quarter)
  - [`#end_of_fiscal_year`](https://github.com/forgecrafted/fiscally#end_of_fiscal_year)
  - [`#end_of_fiscal_quarter`](https://github.com/forgecrafted/fiscally#end_of_fiscal_quarter)
  - [`#quarter_starting_dates`](https://github.com/forgecrafted/fiscally#quarter_starting_dates)
  - [`#quarter_ending_dates`](https://github.com/forgecrafted/fiscally#quarter_ending_dates)

### `#fiscal_start=`
###### `objekt.fiscal_start = 8`

Sets the **month** in which the fiscal calendar will start on the given `objekt`, represented as an `Integer`. The **day** is always set to the first of the month, and is immutable. Defaults to January (`fiscal_start = 1`).

This is the lynchpin of the entire system, adjusting the calendar start and end months to something other than January and December.

Calling `objekt.fiscal_start` without an assignment will return the currently set value.

This value is not frozen, and can be changed at any time.

```ruby
foo = Time.new(2014, 1)
foo.fiscal_start
# => 1

bar = Date.new(2015, 9)
bar.fiscal_start
# => 1

baz = DateTime.new(2025, 9)
baz.fiscal_start
# => 1

# this is mutable
baz.fiscal_start = 4
baz.fiscal_start
# => 4
```

### `#fiscal_quarter`

Returns an integer representing the current quarter.

```ruby
jan01 = Time.new(2015, 1)
jan01.fiscal_quarter
# => 1

jan01.fiscal_start = 4
jan01.fiscal_quarter
# => 4

jan01.fiscal_start = 10
jan01.fiscal_quarter
# => 2
```

### `#all_quarter_months`

Returns an array of arrays, the first level representing the quarters in order, followed by an array of integers representing the months within that quarter.

```ruby
jan01 = Time.new(2015, 1)
jan01.all_quarter_months
# => [[1,2,3], [4,5,6], [7,8,9], [10,11,12]]

jan01.fiscal_start = 4
jan01.all_quarter_months
# => [[4,5,6], [7,8,9], [10,11,12], [1,2,3]]

jan01.fiscal_start = 11
jan01.all_quarter_months
# => [[11,12,1], [2,3,4], [5,6,7], [8,9,10]]
```

### `#fiscal_quarter_months`

Returns an array of integers, representing the months of the current quarter.

```ruby
jan01 = Time.new(2015, 1)
jan01.fiscal_start = 4
jan01.fiscal_quarter_months
# => [1,2,3]

jan01.fiscal_start = 2
jan01.fiscal_quarter_months
# => [11,12,1]

jan01.fiscal_start = 11
jan01.fiscal_quarter_months
# => [11,12,1]

jan01.fiscal_start = 9
jan01.fiscal_quarter_months
# => [12,1,2]
```

### `#first_month_of_quarter`

Returns an integer representing the first month of the current quarter.

```ruby
jan01 = Time.new(2015, 1)
jan01.fiscal_start = 4
jan01.first_month_of_quarter
# => 1

jan01.fiscal_start = 2
jan01.first_month_of_quarter
# => 11

jan01.fiscal_start = 11
jan01.first_month_of_quarter
# => 11

jan01.fiscal_start = 9
jan01.first_month_of_quarter
# => 12
```

### `#first_quarter`

Returns an array of integers, representing the months of the first quarter. Aliased to `q1`.

```ruby
jan01 = Time.new(2015, 1)
jan01.first_quarter
# => [1,2,3]
jan01.q1
# => [1,2,3]
```

### `#second_quarter`

Returns an array of integers, representing the months of the second quarter. Aliased to `q2`.

```ruby
jan01 = Time.new(2015, 1)
jan01.second_quarter
# => [4,5,6]
jan01.q2
# => [4,5,6]
```

### `#third_quarter`

Returns an array of integers, representing the months of the third quarter. Aliased to `q3`.

```ruby
jan01 = Time.new(2015, 1)
jan01.third_quarter
# => [7,8,9]
jan01.q3
# => [7,8,9]
```

### `#fourth_quarter`

Returns an array of integers, representing the months of the fourth quarter. Aliased to `q4`.

```ruby
jan01 = Time.new(2015, 1)
jan01.fourth_quarter
# => [10,11,12]
jan01.q4
# => [10,11,12]
```

### `#beginning_of_fiscal_year`

Returns a new `Time`/`Date`/`DateTime` object representing the starting date of the fiscal year.

```ruby
jan01 = Time.new(2015, 1)
jan01.fiscal_start = 3
jan01.beginning_of_fiscal_year.strftime('%F')
# => '2014-03-01'

jan01.fiscal_start = 9
jan01.beginning_of_fiscal_year.strftime('%F')
# => '2014-09-01'

jan01.fiscal_start = 12
jan01.beginning_of_fiscal_year.strftime('%F')
# => '2014-12-01'
```

The returned object will always match the original object class.

```ruby
Time.new.beginning_of_fiscal_year.class
# => Time
Date.new.beginning_of_fiscal_year.class
# => Date
DateTime.new.beginning_of_fiscal_year.class
# => DateTime
```

### `#beginning_of_fiscal_quarter`

Returns a new `Time`/`Date`/`DateTime` object representing the starting date of the current fiscal quarter.

```ruby
jan01 = Time.new(2015, 1)
jan01.beginning_of_fiscal_quarter.strftime('%F')
# => '2015-01-01'

jan01.fiscal_start = 4
jan01.beginning_of_fiscal_quarter.strftime('%F')
# => '2015-01-01'

jan01.fiscal_start = 2
jan01.beginning_of_fiscal_quarter.strftime('%F')
# => '2014-11-01'

jan01.fiscal_start = 11
jan01.beginning_of_fiscal_quarter.strftime('%F')
# => '2014-11-01'

jan01.fiscal_start = 9
jan01.beginning_of_fiscal_quarter.strftime('%F')
# => '2014-12-01'
```

### `#end_of_fiscal_year`

Returns a new `Time`/`Date`/`DateTime` object representing the last day of the current fiscal year.

```ruby
jan01 = Time.new(2015, 1)
jan01.end_of_fiscal_quarter.strftime('%F')
# => '2015-03-31'

jan01.fiscal_start = 4
jan01.end_of_fiscal_quarter.strftime('%F')
# => '2015-03-31'

jan01.fiscal_start = 2
jan01.end_of_fiscal_quarter.strftime('%F')
# => '2015-01-31'

jan01.fiscal_start = 11
jan01.end_of_fiscal_quarter.strftime('%F')
# => '2015-01-31'

jan01.fiscal_start = 9
jan01.end_of_fiscal_quarter.strftime('%F')
# => '2015-02-28'
```

### `#end_of_fiscal_quarter`

Returns a new `Time`/`Date`/`DateTime` object representing the last day of the current fiscal quarter.

```ruby
jan01 = Time.new(2015, 1)
jan01.end_of_fiscal_quarter.strftime('%F')
# => '2015-03-31'

jan01.fiscal_start = 4
jan01.end_of_fiscal_quarter.strftime('%F')
# => '2015-03-31'

jan01.fiscal_start = 2
jan01.end_of_fiscal_quarter.strftime('%F')
# => '2015-01-31'

jan01.fiscal_start = 11
jan01.end_of_fiscal_quarter.strftime('%F')
# => '2015-01-31'

jan01.fiscal_start = 9
jan01.end_of_fiscal_quarter.strftime('%F')
# => '2015-02-28'
```

### `#quarter_starting_dates`

Returns an array of `Time`/`Date`/`DateTime` objects representing the first day of each quarter for the current fiscal year.

```ruby
jan01 = Time.new(2015, 1)
jan01.quarter_starting_dates.each { |time_obj| puts time_obj.strftime('%F') }
# => '2015-01-01'
# => '2015-04-01'
# => '2015-07-01'
# => '2015-10-01'

jan01.fiscal_start = 2
jan01.quarter_starting_dates.each { |time_obj| puts time_obj.strftime('%F') }
# => '2014-02-01'
# => '2014-05-01'
# => '2014-08-01'
# => '2014-11-01'
```

### `#quarter_ending_dates`

Returns an array of `Time`/`Date`/`DateTime` objects representing the last day of each quarter for the current fiscal year.

```ruby
jan01 = Time.new(2015, 1)
jan01.quarter_ending_dates.each { |time_obj| puts time_obj.strftime('%F') }
# => '2015-03-31'
# => '2015-06-30'
# => '2015-09-30'
# => '2015-12-31'

jan01.fiscal_start = 2
jan01.quarter_ending_dates.each { |time_obj| puts time_obj.strftime('%F') }
# => '2014-04-30'
# => '2014-07-31'
# => '2014-10-31'
# => '2015-01-31'
```
