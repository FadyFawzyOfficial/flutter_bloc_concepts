//! Architecture Tip #1:
//! Predefined types enum constants and generally call that doesn't change at
//! all during the life cycle of your app can be moved inside the constants
//! folder like enums.dart file.
//! Therefore, the code will be more organized.

//* Since there are two almost identical states we'll create an enum for the
//* type of connection we were using.
//* There are two types, so we'll have two members for the connection type info,
//* wifi and mobile.
enum ConnectiionType {
  Wifi,
  Mobile,
}
