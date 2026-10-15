import 'package:excel_plus/excel_plus.dart';
import 'package:gestor_horas/configuration/service_locator.dart';
import 'package:gestor_horas/data/models/time_trackings/time_track_model.dart';
import 'package:gestor_horas/presentation/view_models/date_view_model.dart';
import 'package:gestor_horas/presentation/view_models/employee_viewmodel.dart';
import 'package:gestor_horas/presentation/view_models/schedule_view_model.dart';
import 'package:gestor_horas/presentation/view_models/time_track_viewmodel.dart';
import 'package:intl/intl.dart';

import '../data/models/employees/employee_model.dart';

class ExcelExporter {
  final EmployeeViewModel employeeViewModel = locator<EmployeeViewModel>();
  final DateViewModel dateViewModel = locator<DateViewModel>();
  final ScheduleViewModel scheduleViewModel = locator<ScheduleViewModel>();
  final TimeTrackViewModel timeTrackViewModel = locator<TimeTrackViewModel>();

  final double defaultColumnWidth = 20;

  final CellStyle headerCellStyleRightAlign = CellStyle(
    horizontalAlign: HorizontalAlign.Right,
    fontColorHex: ExcelColor.grey,
  );
  final CellStyle headerCellStyleLeftAlign = CellStyle(
    horizontalAlign: HorizontalAlign.Left,
    fontColorHex: ExcelColor.grey,
  );

  Future<Excel> createExcelFile() async {
    final Excel excel = Excel.createExcel();

    await createSheetForMonthlyHoursResume(excel);

    for (EmployeeModel employee in employeeViewModel.employees) {
      final employeeSheet = excel[employee.name];

      addTitleCellWithStyle(employeeSheet);

      // Print from date to date period
      employeeSheet.updateCell(CellIndex.indexByString('A3'), TextCellValue('Mes'));
      employeeSheet.updateCell(
        CellIndex.indexByString('B3'),
        TextCellValue(
          '${DateFormat('dd MMMM yyyy', 'es_ES').format(dateViewModel.selectedDate.copyWith(day: 1))} - ${DateFormat('dd MMMM yyyy', 'es_ES').format(dateViewModel.selectedDate.copyWith(day: dateViewModel.getTotalDaysOfMonth()))}',
        ),
      );

      // Print employee name
      employeeSheet.updateCell(CellIndex.indexByString('A5'), TextCellValue('Empleado'));
      employeeSheet.updateCell(
        CellIndex.indexByString('B5'),
        TextCellValue(employee.name.toUpperCase()),
      );

      // Print headers of content table
      employeeSheet.updateCell(
        CellIndex.indexByString('A10'),
        TextCellValue('FECHA'),
        cellStyle: headerCellStyleLeftAlign,
      );
      employeeSheet.updateCell(
        CellIndex.indexByString('B10'),
        TextCellValue('DÍA'),
        cellStyle: headerCellStyleLeftAlign,
      );
      employeeSheet.updateCell(
        CellIndex.indexByString('C10'),
        TextCellValue('PRIMERA ENTRADA'),
        cellStyle: headerCellStyleRightAlign,
      );
      employeeSheet.updateCell(
        CellIndex.indexByString('D10'),
        TextCellValue('ÚLTIMA SALIDA'),
        cellStyle: headerCellStyleRightAlign,
      );
      employeeSheet.updateCell(
        CellIndex.indexByString('E10'),
        TextCellValue('HORAS EN HORARIO'),
        cellStyle: headerCellStyleRightAlign,
      );
      employeeSheet.updateCell(
        CellIndex.indexByString('F10'),
        TextCellValue('HORAS REGISTRADAS'),
        cellStyle: headerCellStyleRightAlign,
      );
      employeeSheet.updateCell(
        CellIndex.indexByString('F10'),
        TextCellValue('HORAS EXTRAS'),
        cellStyle: headerCellStyleRightAlign,
      );

      int rowsToSkip = 10;
      for (int dayOfMonth = 0; dayOfMonth < dateViewModel.getTotalDaysOfMonth(); dayOfMonth++) {
        final DateTime currentDate = dateViewModel.selectedDate.copyWith(day: dayOfMonth + 1);
        List<TimeTrackModel> timeTrackingsOfEmployee = await timeTrackViewModel
            .getTimeTrackingsByDateAndEmployee(currentDate, employee);

        // Print date
        employeeSheet.updateCell(
          CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: dayOfMonth + rowsToSkip),
          TextCellValue(DateFormat.yMd().format(currentDate)),
        );

        // Print day of the week
        employeeSheet.updateCell(
          CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: dayOfMonth + rowsToSkip),
          TextCellValue(DateFormat.EEEE('es_ES').format(currentDate)),
        );

        if (timeTrackingsOfEmployee.isNotEmpty) {
          DateTime firstEntryOfTheDay = timeTrackingsOfEmployee.first.startTime!;
          DateTime lastEntryOfTheDay = timeTrackingsOfEmployee.length > 1
              ? timeTrackingsOfEmployee.last.finishTime!
              : timeTrackingsOfEmployee[0].finishTime!;

          // Print first time track time of the day
          employeeSheet.updateCell(
            CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: dayOfMonth + rowsToSkip),
            TextCellValue(
              timeTrackingsOfEmployee.isEmpty
                  ? ''
                  : DateFormat.Hm('es_ES').format(firstEntryOfTheDay),
            ),
          );

          // Print last time track time of the day
          employeeSheet.updateCell(
            CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: dayOfMonth + rowsToSkip),
            TextCellValue(
              timeTrackingsOfEmployee.isEmpty
                  ? ''
                  : DateFormat.Hm('es_ES').format(lastEntryOfTheDay),
            ),
          );
        }
      }

      employeeSheet.setColumnWidth(0, 20);
      employeeSheet.setDefaultColumnWidth(defaultColumnWidth);
      employeeSheet.setDefaultRowHeight(20);
    }

    return excel;
  }

  Future<void> createSheetForMonthlyHoursResume(Excel excel) async {
    final String sheetName = 'Resumen Horas';
    final sheet = excel[sheetName];

    excel.setDefaultSheet(sheetName);
    excel.rename('Sheet1', 'Sheet');
    excel.delete('Sheet');

    // Print header
    addTitleCellWithStyle(sheet);

    // Print days of the month
    for (int i = 0; i < dateViewModel.getTotalDaysOfMonth(); i++) {
      sheet.updateCell(
        cellStyle: headerCellStyleRightAlign,
        CellIndex.indexByColumnRow(columnIndex: i + 1, rowIndex: 2),
        TextCellValue('${DateFormat("MMMM").format(dateViewModel.selectedDate)} ${i + 1}'),
      );
    }

    // Print Total Hours header
    sheet.updateCell(
      cellStyle: headerCellStyleRightAlign,
      CellIndex.indexByColumnRow(columnIndex: dateViewModel.getTotalDaysOfMonth() + 2, rowIndex: 2),
      TextCellValue('Total'),
    );

    // Print employees info
    for (int i = 0; i < employeeViewModel.employees.length; i++) {
      EmployeeModel employee = employeeViewModel.employees[i];

      // Print employee names
      sheet.updateCell(CellIndex.indexByString('A${i + 4}'), TextCellValue(employee.name));

      // Print employee daily hours
      for (int j = 0; j < dateViewModel.getTotalDaysOfMonth(); j++) {
        Duration timeWorkedInDay = await timeTrackViewModel.getDailyDurationForEmployeeByDay(
          employee.id!,
          j + 1,
        );

        // Print daily hours
        sheet.updateCell(
          cellStyle: CellStyle(horizontalAlign: HorizontalAlign.Right),
          CellIndex.indexByColumnRow(columnIndex: j + 1, rowIndex: i + 3),
          TextCellValue(
            timeWorkedInDay.inMinutes != 0
                ? '${timeWorkedInDay.inHours.remainder(24)}h ${timeWorkedInDay.inMinutes.remainder(60)}min'
                : '-',
          ),
        );

        // Print total hours worked in month
        Duration timeWorkedInMonth = await timeTrackViewModel.getTimeWorkedInMonthByEmployee(
          employee.id!,
        );
        sheet.updateCell(
          cellStyle: CellStyle(horizontalAlign: HorizontalAlign.Right),
          CellIndex.indexByColumnRow(
            columnIndex: dateViewModel.getTotalDaysOfMonth() + 2,
            rowIndex: i + 3,
          ),
          TextCellValue(
            timeWorkedInMonth.inMinutes != 0
                ? '${timeWorkedInMonth.inHours.remainder(24)}h ${timeWorkedInMonth.inMinutes.remainder(60)}min'
                : '-',
          ),
        );
      }
    }

    sheet.setColumnWidth(0, 40);
    sheet.setDefaultColumnWidth(defaultColumnWidth);
    sheet.setDefaultRowHeight(20);
  }

  void addTitleCellWithStyle(Sheet sheet) {
    sheet.updateCell(
      CellIndex.indexByString('A1'),
      TextCellValue('Hoja de horas mensuales'),
      cellStyle: CellStyle(
        fontColorHex: ExcelColor.orangeAccent,
        fontSize: 20,
        fontFamily: 'Arial',
        bold: true,
      ),
    );
  }
}
