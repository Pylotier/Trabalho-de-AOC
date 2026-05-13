# 67. Fazer um algoritmo que receba um número (1 < número <= 50000 e, caso não seja, deve ser novamente solicitado) e demonstre o primeiro número primo após a ele.
# Link Tarefa: https://forms.gle/KwLKRFiXka1T3x8fA
# 40.	Receba 2 números inteiros. Verifique e mostre todos os números primos existentes entre eles. LISTA 1 
.data
	msg01: .asciiz"Digite um número maior do que 1 e menor ou igual que 50000: "
	msgMenor: .asciiz"Número menor do que 1!\n"
	msgMaior: .asciiz"Número maior do que 50000!\n"
	msgPrimo: .asciiz"O proximo número primo de é "

.text
main:
	li $v0, 4
	la $a0, msg01
	syscall
	
	li $v0, 5
	syscall
	
	add $t1, $v0, 0
	
verificar: # Verifica se o valor segue o parametro
	ble $t1, 1, menorQue1
	bgt $t1, 50000, maiorQue50k
	add $t2, $t1, 1 # Certifica que começa com o proximo número
	li $s0, 1 # Define a variavel para começar como 1 na divisão principal
	j acharPrimo
menorQue1:
	li $v0, 4
	la $a0, msgMenor
	syscall
	j main
	
maiorQue50k:
	li $v0, 4
	la $a0, msgMaior
	syscall
	j main
	
acharPrimo:
	rem $s1, $t2, $s0 # Guarda o resultado do resto, $s0 sera o i
	beq $s1, 0, nDivisores # Pergunta se o resto é igual a 0
	add $s0, $s0, 1 # Se não soma $s0 1 para a proxima divisão
	bne $s0, $t2, acharPrimo # Continua o loop até que $s0 seja igual a $t2
	j continuar
nDivisores:
	add $t7, $t7, 1 # Contador de divosores
	add $s0, $s0, 1 # Soma $s0 1 para continuar o fluxo
	j acharPrimo
continuar:
	blt $t7, 2, primo # Após finalizar o loop do 'acharPrimo' ele pergunta quantas divisões foram contadas e se é menor do que 2
	j naoPrimo # Senão vai para 'naoPrimo'
primo: # Fala o número primo encontrado
	li $v0, 4
	la $a0, msgPrimo
	syscall
	
	li $v0, 1
	add $a0, $t2, 0
	syscall
	j fim
	
naoPrimo: # Inicia o loop do 'acharPrimos' com o contador e divisor zerado, segue o proximo número a verificar
	add $t2, $t2, 1
	li $t7, 0
	li $s0, 1
	j acharPrimo
fim:

	
	