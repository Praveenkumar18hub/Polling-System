; multi-segment executable file template.

data segment
    ; add your data here!
    
    
    
    
    ;ui
    
    head db "          Polling Sysytem",0dh , 0ah , 24h
    modh1 db " 1.ADMINISTRATOR" , 0dh , 0ah , 24h
    modh2 db " 2.ELECTION COMMISSION",0ah , 0dh,24h
    modh3 db " 3.VOTER" , 0ah , 0dh , 24h
    exitt db " 4.EXIT" , 0ah , 0dh , 24h
    inp db "     Select you'r option  $"
    input db , 0h
    nl db 0dh , 0ah , 24h
    
    ;1. Administrator
    
    admin db  "          ADMINISTRATOR" , 0ah , 0dh , 24h
    admin_pass db "Enter admin pin(4 digit) : $"
    adpass db 4
    addelect db "1.ADD ELECTION COMMISSIONOR" , 0dh , 0ah , 24h
    admin_exit db "2.GO BACK" , 0ah , 0dh , 24h
    
        
        ;1. Add commissionor
        com_name db "Enter commissionor name : $"
        com_pass db "Enter commissionor password(5 digit) : $"
        add_msg db "Commissionor added" , 0ah , 0dh , 24h
        coname db 100,?,100 dup(' ')
        copass db 100,?,100 dup(' ')
        
    ;2. Election commssion
     ;ask comm password/id 
     
    ; elec db "           ELECTION COMMISSION", 0dh , 0ah . 24h 
     
     add_cand db "1. Add candidate : $"
        number_of_cand db "Enter number of candidate : $"
        numcan db , 0h
        can_id db "Enter candidate id : $"
        canid db , 0h
        can_add_msg db "Candidate added" , 0dh , 0ah , 24h
        
     rem_cand db "2. Remove candidate : $"
        can_rem_msg db "Candidate removed" , 0dh , 0ah , 24h
        
     add_voter db "3. Add voter : $"
        input_voter_id db "Enter voter id : "
        Avoter db  , 0h
        voter_add_msg db "Voter added" , 0dh , 0ah , 24h
        
     rem_voter db "4. Remove voter : $"
        ;ask voter id
        voter_rem_msg db "Voter removed" , 0dh , 0ah , 24h
     ;go back
     
     
     ;3. Voter 
        ;ask voter id
        title_voter: db "           VOTER" , 0dh , 0ah , 24h
        choose_candidate: db "Chosse candidate to vote : "
        voted_msg: db "voted" , 0dh , 0ah , 24h
        in_vote: db "Kalla votuuuuuu!!"
        no_vote_id: db "Voter id does not exist" , 0dh , 0ah , 24h
        ;go back
        
        
     ;4. Exit
      
 
    pkey db "press any key...$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    menu proc
        lea dx , head
        mov ah , 9h
        int 21h
        
        lea  dx , modh1
        mov ah , 9h
        int 21h
        
        lea dx , modh2
        mov ah , 9h
        int 21h
        
        lea dx , modh3
        mov ah , 9h
        int 21h
        
        lea dx , exitt
        mov ah , 9h
        int 21h
        
        lea dx  , inp
        mov ah , 9h
        int 21h
        
        mov ah , 1h
        int 21h 
        sub al , 30h
        mov input , al
        
        
        cmp input , 01h
        jne call menu
        call administrator
 
        
        cmp input , 02h
        jne call menu
        call election_commission
        
        cmp input , 03h
        jne call menu
        call voter
        
        cmp input , 04h
        jne call menu 
 
    menu endp 
    
    
    administrator proc 

            lea dx , admin
            mov ah , 9h
            int 21h
            
            lea dx , admin_pass
            mov ah , 9h
            int 21h
            
            mov ah , adpass
            mov cx , 4
            
            read:
            mov ah , 1
            int 21h
            mov dl , 8
            mov ah , 2
            int 21h
            mov dl , '*'
            mov ah , 2
            int 21h
            inc si
            loop read 
            
 
            lea dx , addelect
            mov ah , 9h
            int 21h

            lea dx , admin_exit
            mov ah , 9h
            int 21h
            
            lea dx , inp
            mov ah , 9h
            int 21h
            
            mov ah , 1h
            int 21h
            
            sub al , 30h
            
            cmp al , 01h
            je call add_elect
            
            cmp al , 02h
            je call menu
 
    administrator endp
 
    add_elect proc
        
        lea dx , com_name
        mov ah , 9h
        int 21h
        
        mov dx , offset coname
        mov ah , 0ah
        int 21h

        lea dx , nl
        mov ah , 9h
        int 21h

        lea dx , com_pass
        mov ah , 9h
        int 21h
        
        read1:
        mov cx , 5
        mov ah , 1
        int 21h
        mov dl , 8
        mov ah , 2
        int 21h
        mov dl , '*'
        int 21h
        loop read
        
        lea dx ,add_msg
        mov ah , 9h
        int 21h
        
    add_elect endp
    
    
    
    
    
    
     exit:
    

    
        
        
    
    
            
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

print:
xor bx , bx
mov bl,coname[1]
mov coname[bx+2],'$'
mov dx , offset coname+2
mov ah , 9
int 21h
ret



election_commission proc
        lea dx ,add_cand
        mov ah , 9h
        int 21h         
    election_commission endp
    
    voter proc
        lea dx , title_voter
        mov ah , 9h
        int 21h 
    voter endp

end start ; set entry point and stop the assembler.