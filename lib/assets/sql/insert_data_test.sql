--BEGIN TRANSACTION;

-- Limpiar datos anteriores.
-- Se eliminan primero las tablas dependientes.
DELETE FROM time_trackings;
DELETE FROM employee_schedules;
DELETE FROM schedules;
DELETE FROM employees;

-- =========================================
-- EMPLOYEES
-- =========================================

INSERT INTO employees (id, name, hours_in_contract) VALUES
(1, 'Laura Martínez', 40),
(2, 'Marcos García', 30),
(3, 'Sara López', 20),
(4, 'Diego Fernández', 40),
(5, 'Elena Torres', 25);

-- =========================================
-- SCHEDULES
-- =========================================
-- Los horarios utilizan una fecha ficticia fija.
-- Se conserva el formato ISO de fecha y hora.
-- Weekdays: Mo, Tu, We, Th, Fr, Sa, Su.

INSERT INTO schedules (
    id,
    start_time,
    finish_time,
    start_second_time,
    finish_second_time,
    weekdays,
    color
) VALUES
(
    1,
    '2000-01-01T08:00:00',
    '2000-01-01T16:00:00',
    NULL,
    NULL,
    'Mo,Tu,We,Th,Fr',
    '#4CAF50'
),
(
    2,
    '2000-01-01T09:00:00',
    '2000-01-01T13:00:00',
    '2000-01-01T17:00:00',
    '2000-01-01T21:00:00',
    'Mo,Tu,We,Th,Fr',
    '#2196F3'
),
(
    3,
    '2000-01-01T16:00:00',
    '2000-01-01T23:00:00',
    NULL,
    NULL,
    'Mo,Tu,We,Th,Fr,Sa',
    '#FF9800'
),
(
    4,
    '2000-01-01T10:00:00',
    '2000-01-01T14:00:00',
    NULL,
    NULL,
    'Sa,Su',
    '#9C27B0'
);

-- =========================================
-- EMPLOYEE_SCHEDULES
-- =========================================

INSERT INTO employee_schedules (
    id_employee,
    id_schedule,
    assigned_week
) VALUES
(1, 1, 'Semana 1'),
(1, 1, 'Semana 2'),
(2, 2, 'Semana 1'),
(2, 3, 'Semana 2'),
(3, 2, 'Semana 1'),
(3, 2, 'Semana 2'),
(4, 1, 'Semana 1'),
(4, 3, 'Semana 2'),
(5, 3, 'Semana 1'),
(5, 4, 'Semana 2');

-- =========================================
-- TIME_TRACKINGS
-- =========================================
-- Semana del 2 al 8 de noviembre.
-- Semana del 9 al 15 de noviembre.
--
-- Los registros que cruzan medianoche
-- aparecen divididos en dos registros.

INSERT INTO time_trackings (
    id,
    id_employee,
    start_time,
    finish_time
) VALUES

-- LAURA (40 horas contratadas)

(1, 1, '2026-11-02T08:00:00', '2026-11-02T16:00:00'),
(2, 1, '2026-11-03T08:00:00', '2026-11-03T16:00:00'),
(3, 1, '2026-11-04T08:15:00', '2026-11-04T16:00:00'),
(4, 1, '2026-11-05T08:00:00', '2026-11-05T16:00:00'),
(5, 1, '2026-11-06T08:00:00', '2026-11-06T15:30:00'),

-- Segunda semana: varios fichajes en un mismo día.

(6, 1, '2026-11-09T08:00:00', '2026-11-09T12:00:00'),
(7, 1, '2026-11-09T13:00:00', '2026-11-09T17:00:00'),
(8, 1, '2026-11-10T08:00:00', '2026-11-10T16:00:00'),
(9, 1, '2026-11-11T08:00:00', '2026-11-11T16:00:00'),
(10, 1, '2026-11-12T08:00:00', '2026-11-12T16:00:00'),

-- MARCOS (30 horas contratadas)

(11, 2, '2026-11-02T09:00:00', '2026-11-02T13:00:00'),
(12, 2, '2026-11-02T17:00:00', '2026-11-02T21:00:00'),
(13, 2, '2026-11-03T09:00:00', '2026-11-03T13:00:00'),
(14, 2, '2026-11-04T09:00:00', '2026-11-04T13:00:00'),
(15, 2, '2026-11-05T09:00:00', '2026-11-05T13:00:00'),
(16, 2, '2026-11-06T09:00:00', '2026-11-06T13:00:00'),

-- SARA (20 horas contratadas)

(17, 3, '2026-11-02T09:00:00', '2026-11-02T13:00:00'),
(18, 3, '2026-11-03T09:00:00', '2026-11-03T13:00:00'),
(19, 3, '2026-11-04T09:00:00', '2026-11-04T13:00:00'),
(20, 3, '2026-11-05T09:00:00', '2026-11-05T13:00:00'),
(21, 3, '2026-11-06T09:00:00', '2026-11-06T13:00:00'),

-- DIEGO (40 horas contratadas)
-- Jornada que cruza medianoche, dividida en dos registros.

(22, 4, '2026-11-09T22:00:00', '2026-11-10T00:00:00'),
(23, 4, '2026-11-10T00:00:00', '2026-11-10T02:00:00'),
(24, 4, '2026-11-10T16:00:00', '2026-11-10T23:00:00'),
(25, 4, '2026-11-11T16:00:00', '2026-11-11T23:00:00'),

-- ELENA (25 horas contratadas)

(26, 5, '2026-11-09T16:00:00', '2026-11-09T22:00:00'),
(27, 5, '2026-11-10T16:00:00', '2026-11-10T22:00:00'),
(28, 5, '2026-11-11T16:00:00', '2026-11-11T22:00:00'),

-- FICHAJE ABIERTO
-- Marcos comenzó a trabajar el jueves 12.
-- Todavía no ha pulsado Stop.

(29, 2, '2026-11-12T17:00:00', NULL),

-- FICHAJE ABIERTO
-- Sara comenzó a trabajar el jueves 12.
-- Contiene dos registros abiertos no válidos.

(30, 3, '2026-11-12T18:00:00', NULL),
(31, 3, '2026-11-12T19:00:00', NULL);

--COMMIT;