//
//  SwitchRow.swift
//  QuickTableViewController
//
//  Created by Ben on 01/09/2015.
//  Copyright (c) 2015 bcylin.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

/// A class that represents a row with a switch.
public final class SwitchRow<T: SwitchCell>: Row, RowStyle, Equatable {

  // MARK: - Initializer

  /// Initializes a `SwitchRow` with a title, a switch state and an action closure.
  /// The icon and the customization closure are optional.
  public init(
    title: String,
    switchValue: Bool,
    icon: Icon? = nil,
    customization: ((UITableViewCell, Row & RowStyle) -> Void)? = nil,
    action: ((Row) -> Void)?
  ) {
    self.title = title
    self.switchValue = switchValue
    self.icon = icon
    self.customize = customization
    self.action = action
  }

  private init() {
    fatalError("init without any argument is not supported")
  }

  // MARK: - Row

  /// The title text of the row.
  public let title: String

  /// The subtitle is disabled in `SwitchRow`.
  public let subtitle: Subtitle? = nil

  /// A closure that will be invoked when the `switchValue` is changed.
  public let action: ((Row) -> Void)?

  // MARK: - SwitchRow

  /// The state of the switch.
  public var switchValue: Bool = false {
    didSet {
      if switchValue != oldValue {
        action?(self)
      }
    }
  }

  // MARK: - RowStyle

  /// The type of the table view cell to display the row.
  public let cellType: UITableViewCell.Type = T.self

  /// The reuse identifier of the table view cell to display the row. The default value is **SwitchCell**.
  public let cellReuseIdentifier: String = T.reuseIdentifier

  /// The cell style is `.default`.
  public let cellStyle: UITableViewCellStyle = .default

  /// The icon of the row.
  public let icon: Icon?

  /// The default accessory type is `.none`.
  public let accessoryType: UITableViewCellAccessoryType = .none

  /// The `SwitchRow` should not be selectable.
  public let isSelectable: Bool = false

  /// The additional customization during cell configuration.
  public let customize: ((UITableViewCell, Row & RowStyle) -> Void)?

  // MARK: Equatable

  /// Returns true iff `lhs` and `rhs` have equal titles, switch values, and icons.
  public static func == (lhs: SwitchRow, rhs: SwitchRow) -> Bool {
    return
      lhs.title == rhs.title &&
      lhs.switchValue == rhs.switchValue &&
      lhs.icon == rhs.icon
  }

}
