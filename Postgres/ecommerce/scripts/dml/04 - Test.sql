use ecommerce;

delete from tb_person;
delete from tb_document;
delete from tb_person_document;

-- tb_person
insert into tb_person (id, type_id, classification_id, name, birth) values (1, 1, 1, 'David Lancioni', '1979-02-15');

-- tb_document
insert into tb_document (id, name) values (1, 'RG');

-- tb_person_document
insert into tb_person_document (id, person_id, document_id, number) values (1, 1, 1, '26.705.777-5')




