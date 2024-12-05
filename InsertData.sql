INSERT INTO SERVICECOST (unlock, usable) VALUES
                                             (1.00, 0.15),
                                             (0.99, 0.10),
                                             (2.50, 0.25);

INSERT INTO SCOOTERMODEL (designation, autonomy) VALUES
                                                     ('Model X', 50),
                                                     ('Model Y', 70),
                                                     ('Model Z', 100),
                                                     ('Eco Scooter', 40),
                                                     ('Pro Scooter', 120),
                                                     ('Urban Rider', 60),
                                                     ('Speedster', 90);

INSERT INTO TYPEOF (reference, nodays, price) VALUES
                                                  ('resident', 30, 25.00),
                                                  ('tourist', 7, 10.00);

INSERT INTO STATION (latitude, longitude) VALUES
                                              (40.7128, -74.0060), -- New York
                                              (51.5074, -0.1278), -- London
                                              (48.8566, 2.3522); -- Paris

INSERT INTO PERSON (email, taxnumber, name) VALUES
                                                ('cristiano.ronaldo@portugal.com', 123456789, 'Cristiano Ronaldo'),
                                                ('mariza.fado@portugal.com', 987654321, 'Mariza'),
                                                ('jose.mourinho@football.com', 456789123, 'José Mourinho'),
                                                ('catarina.furtado@tvportugal.com', 789123456, 'Catarina Furtado'),
                                                ('ricardo.araújo@humor.com', 321654987, 'Ricardo Araújo Pereira'),
                                                ('rui.veloso@musicportugal.com', 654321789, 'Rui Veloso'),
                                                ('ana.moura@fado.com', 159753486, 'Ana Moura');

INSERT INTO CLIENT (person, dtregister) VALUES
                                            (1, '2023-01-15 10:30:00'), -- Cliente 1: Cristiano Ronaldo
                                            (2, '2023-02-20 14:15:00'), -- Cliente 2: Mariza
                                            (3, '2023-03-25 09:45:00'), -- Cliente 3: José Mourinho
                                            (4, '2023-04-10 11:00:00'); -- Cliente 4: Catarina Furtado

INSERT INTO EMPLOYEE (person) VALUES
                                  (5), -- Funcionário 1
                                  (6), -- Funcionário 2
                                  (7); -- Funcionário 3

INSERT INTO REPLACEMENTORDER (dtorder, dtreplacement, roccupation, station) VALUES
                                                                                ('2023-01-01 08:00:00', '2023-01-01 10:00:00', 50, 1), -- Substituição para estação 1
                                                                                ('2023-04-05 07:45:00', NULL, 20, 2), -- Substituição para estação 2
                                                                                ('2023-03-10 09:00:00', '2023-03-10 11:30:00', 75, 3); -- Substituição para estação 3

INSERT INTO SCOOTER (weight, maxvelocity, battery, model) VALUES
                                                              (15.00, 25.00, 50, 1), -- Scooter leve e rápida do modelo 1
                                                              (18.50, 30.00, 60, 2), -- Scooter do modelo 2
                                                              (20.00, 20.00, 70, 3), -- Scooter robusta do modelo 3
                                                              (12.75, 15.00, 40, 4), -- Scooter do modelo 4
                                                              (17.25, 27.50, 65, 5), -- Scooter intermediária do modelo 5
                                                              (16.00, 22.00, 50, 6), -- Scooter do modelo 6
                                                              (14.50, 28.00, 55, 7), -- Scooter leve e veloz do modelo 7
                                                              (16.75, 24.00, 48, 1), -- Outra scooter do modelo 1
                                                              (17.50, 29.00, 58, 2), -- Outra scooter do modelo 2
                                                              (19.00, 19.00, 68, 3), -- Outra scooter do modelo 3
                                                              (12.75, 16.00, 38, 4), -- Outra scooter do modelo 4
                                                              (17.25, 26.00, 63, 5), -- Outra scooter do modelo 5
                                                              (16.00, 23.00, 52, 6), -- Outra scooter do modelo 6
                                                              (14.50, 29.50, 54, 7);

INSERT INTO DOCK (station, state, scooter) VALUES
                                               (1, 'free', NULL), -- Dock livre na estação 1
                                               (1, 'occupy', 1), -- Dock ocupada com a scooter 1 na estação 1
                                               (2, 'under maintenance', NULL), -- Dock livre na estação 2
                                               (2, 'occupy', 2), -- Dock ocupada com a scooter 2 na estação 2
                                               (3, 'free', NULL), -- Dock livre na estação 3
                                               (3, 'occupy', 3); -- Dock ocupada com a scooter 3 na estação 3


INSERT INTO REPLACEMENT (dtreplacement, action, dtreporder, repstation, employee) VALUES
                                                                                      ('2023-01-01 12:00:00', 'inplace', '2023-01-01 08:00:00', 1, 5), -- Substituição concluída na estação 1
                                                                                      ('2023-03-10 12:30:00', 'remove', '2023-03-10 09:00:00', 3, 7); -- Substituição na estação 3


INSERT INTO CARD (credit, typeof, client) VALUES
                                              (50.00, 'resident', 1), -- Cartão para o cliente 1, tipo "resident"
                                              (20.00, 'tourist', 2), -- Cartão para o cliente 2, tipo "tourist"
                                              (35.50, 'resident', 3), -- Cartão para o cliente 3, tipo "resident"
                                              (15.00, 'tourist', 4); -- Cartão para o cliente 4, tipo "tourist"


INSERT INTO TOPUP (dttopup, card, value) VALUES
                                             ('2023-01-01 10:00:00', 1, 20.00), -- Recarga de 20€ para o cartão 1
                                             ('2023-02-15 12:30:00', 2, 15.50), -- Recarga de 15.50€ para o cartão 2
                                             ('2023-03-10 14:45:00', 3, 30.00), -- Recarga de 30€ para o cartão 3
                                             ('2023-04-05 09:00:00', 4, 25.00); -- Recarga de 25€ para o cartão 4

INSERT INTO TRAVEL (dtinitial, comment, evaluation, dtfinal, client, scooter, stinitial, stfinal) VALUES
                                                                                                      ('2023-01-01 08:00:00', 'Smooth ride', 5, '2023-01-01 08:30:00', 1, 1, 1, 2), -- Viagem de 1 para 2
                                                                                                      ('2023-02-15 09:00:00', NULL, NULL, '2023-02-15 09:45:00', 2, 2, 2, 3), -- Viagem sem avaliação
                                                                                                      ('2023-03-10 10:15:00', 'Scooter was slow', 3, '2023-03-10 10:45:00', 3, 3, 3, 2), -- Avaliação mediana
                                                                                                      ('2023-04-05 12:00:00', 'Great service', 4, '2023-04-05 12:30:00', 4, 4, 2, 1); -- Avaliação boa




