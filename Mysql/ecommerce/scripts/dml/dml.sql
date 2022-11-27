use ecommerce;

truncate table tb_message;
INSERT INTO tb_message (id, message) VALUES (1, 'Ação inválida, deve ser [I]nsert, [U]pdate, [D]elete ou [S]elect');
INSERT INTO tb_message (id, message) VALUES (2, 'Campos %1 é obrigatório');
INSERT INTO tb_message (id, message) VALUES (3, 'Valor informado para o campo %1 (%2) não existe no cadastro de %3');
INSERT INTO tb_message (id, message) VALUES (4, 'Valor informado para o campo %1 é maior do que o máximo permitido (%3)');

INSERT INTO tb_message (id, message) VALUES (10, 'Registro incluído com sucesso');
INSERT INTO tb_message (id, message) VALUES (11, 'Registro alterado com sucesso');
INSERT INTO tb_message (id, message) VALUES (12, 'Registro excluído com sucesso');