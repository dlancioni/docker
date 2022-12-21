use ecommerce;

delete from tb_message;

insert into tb_message values (1, 'Ação inválida, deve ser [I]nsert, [U]pdate, [D]elete ou [S]elect');
insert into tb_message values (2, 'Campo Id é obrigatório na alteração ou exclusão de registros');
insert into tb_message values (3, 'Valor informado para o campo %1 não existe no cadastro de %2');
insert into tb_message values (4, 'Campo %1 é obrigatório');
insert into tb_message values (5, 'Não foi possível excluir os registros, existem registros relacionados no cadastro de %1');
insert into tb_message values (6, 'Registro informado (%1) não encontrado para %2');

insert into tb_message values (10, 'Registro (%1) incluído com sucesso');
insert into tb_message values (11, 'Registro (%1) alterado com sucesso');
insert into tb_message values (12, 'Registro (%1) excluído com sucesso');
