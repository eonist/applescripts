FasdUAS 1.101.10   ��   ��    k             l     ��  ��    w qNote: we use load_script to load plain-text .applescript files, which cant be loaded directly without this method     � 	 	 � N o t e :   w e   u s e   l o a d _ s c r i p t   t o   l o a d   p l a i n - t e x t   . a p p l e s c r i p t   f i l e s ,   w h i c h   c a n t   b e   l o a d e d   d i r e c t l y   w i t h o u t   t h i s   m e t h o d   
  
 l     ��  ��    � �Note: we use .applescript instead of .scpt files because its easier to put plain text script files under version control like github     �   N o t e :   w e   u s e   . a p p l e s c r i p t   i n s t e a d   o f   . s c p t   f i l e s   b e c a u s e   i t s   e a s i e r   t o   p u t   p l a i n   t e x t   s c r i p t   f i l e s   u n d e r   v e r s i o n   c o n t r o l   l i k e   g i t h u b      l     ��  ��   a[Note: You can load compiled scripts (.scpt) or plain text scripts (.applescript). Make sure, though, that your .applescript files are encoded as either Mac (what AppleScript Editor uses) UTF-8 (if you use another text editor). Any scripts loaded are expected to be installed into your Scripts directory. Use the line below to reference the script:     �  � N o t e :   Y o u   c a n   l o a d   c o m p i l e d   s c r i p t s   ( . s c p t )   o r   p l a i n   t e x t   s c r i p t s   ( . a p p l e s c r i p t ) .   M a k e   s u r e ,   t h o u g h ,   t h a t   y o u r   . a p p l e s c r i p t   f i l e s   a r e   e n c o d e d   a s   e i t h e r   M a c   ( w h a t   A p p l e S c r i p t   E d i t o r   u s e s )   U T F - 8   ( i f   y o u   u s e   a n o t h e r   t e x t   e d i t o r ) .   A n y   s c r i p t s   l o a d e d   a r e   e x p e c t e d   t o   b e   i n s t a l l e d   i n t o   y o u r   S c r i p t s   d i r e c t o r y .   U s e   t h e   l i n e   b e l o w   t o   r e f e r e n c e   t h e   s c r i p t :      l     ��  ��    H Bremember to import this method before you use it with a property:      �   � r e m e m b e r   t o   i m p o r t   t h i s   m e t h o d   b e f o r e   y o u   u s e   i t   w i t h   a   p r o p e r t y :        l      ��  ��   ��
property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt")--prerequisite for loading .applescript filesproperty ListAsserter : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "list:ListAsserter.applescript")) my ListAsserter's equals_to({1, 2, 3, 4}, {1, 2, 3, 4})
if my ListAsserter's equals_to({1, 2, 3, 4}, {1, 2, 3, 4}) then	log "yes"else	log "no"end if
     �  � 
 p r o p e r t y   S c r i p t L o a d e r   :   l o a d   s c r i p t   a l i a s   ( ( p a t h   t o   s c r i p t s   f o l d e r   f r o m   u s e r   d o m a i n   a s   t e x t )   &   " f i l e : S c r i p t L o a d e r . s c p t " ) - - p r e r e q u i s i t e   f o r   l o a d i n g   . a p p l e s c r i p t   f i l e s  p r o p e r t y   L i s t A s s e r t e r   :   m y   S c r i p t L o a d e r ' s   l o a d _ s c r i p t ( a l i a s   ( ( p a t h   t o   s c r i p t s   f o l d e r   f r o m   u s e r   d o m a i n   a s   t e x t )   &   " l i s t : L i s t A s s e r t e r . a p p l e s c r i p t " ) )    m y   L i s t A s s e r t e r ' s   e q u a l s _ t o ( { 1 ,   2 ,   3 ,   4 } ,   { 1 ,   2 ,   3 ,   4 } ) 
 i f   m y   L i s t A s s e r t e r ' s   e q u a l s _ t o ( { 1 ,   2 ,   3 ,   4 } ,   { 1 ,   2 ,   3 ,   4 } )   t h e n  	 l o g   " y e s "  e l s e  	 l o g   " n o "  e n d   i f 
   ��  i          I      �� !���� 0 load_script   !  "�� " o      ���� 0 apple_script_path  ��  ��     k     { # #  $ % $ Q     x & ' ( & r    
 ) * ) I   �� +��
�� .sysoloadscpt        file + o    ���� 0 apple_script_path  ��   * o      ���� 0 script_object   ' R      ���� ,
�� .ascrerr ****      � ****��   , �� -��
�� 
errn - d       . . m      �������   ( l   x / 0 1 / k    x 2 2  3 4 3 r     5 6 5 m     7 7 � 8 8   6 o      ���� 0 script_text   4  9 : 9 Q    1 ; < = ; l     > ? @ > r      A B A I   �� C��
�� .rdwrread****        **** C o    ���� 0 apple_script_path  ��   B o      ���� 0 script_text   ? ( " Try reading as Mac encoding first    @ � D D D   T r y   r e a d i n g   a s   M a c   e n c o d i n g   f i r s t < R      ���� E
�� .ascrerr ****      � ****��   E �� F��
�� 
errn F d       G G m      �������   = l  ( 1 H I J H l  ( 1 K L M K r   ( 1 N O N I  ( /�� P Q
�� .rdwrread****        **** P o   ( )���� 0 apple_script_path   Q �� R��
�� 
as   R m   * +��
�� 
utf8��   O o      ���� 0 script_text   L   Finally try UTF-8    M � S S $   F i n a l l y   t r y   U T F - 8 I &   Error reading script's encoding    J � T T @   E r r o r   r e a d i n g   s c r i p t ' s   e n c o d i n g :  U�� U Q   2 x V W X V r   5 H Y Z Y I  5 F�� [��
�� .sysodsct****        scpt [ l  5 B \���� \ b   5 B ] ^ ] b   5 @ _ ` _ b   5 > a b a b   5 < c d c b   5 : e f e b   5 8 g h g m   5 6 i i � j j  s c r i p t   s h o   6 7��
�� 
ret  f o   8 9���� 0 script_text   d o   : ;��
�� 
ret  b m   < = k k � l l  e n d   s c r i p t   ` o   > ?��
�� 
ret  ^ m   @ A m m � n n  r e t u r n   s��  ��  ��   Z o      ���� 0 script_object   W R      �� o p
�� .ascrerr ****      � **** o o      ���� 0 e   p �� q r
�� 
errn q o      ���� 0 n   r �� s t
�� 
ptlr s o      ���� 0 p   t �� u v
�� 
erob u o      ���� 0 f   v �� w��
�� 
errt w o      ���� 0 t  ��   X k   P x x x  y z y I  P a�� {��
�� .sysodlogaskr        TEXT { b   P ] | } | b   P Y ~  ~ b   P W � � � b   P S � � � m   P Q � � � � � , E r r o r   r e a d i n g   l i b r a r y   � o   Q R���� 0 apple_script_path   � m   S V � � � � �     o   W X���� 0 e   } m   Y \ � � � � � : P l e a s e   e n c o d e   a s   M a c   o r   U T F - 8��   z  ��� � R   b x�� � �
�� .ascrerr ****      � **** � o   v w���� 0 e   � �� � �
�� 
errn � o   f g���� 0 n   � �� � �
�� 
ptlr � o   j k���� 0 p   � �� � �
�� 
erob � o   n o���� 0 f   � �� ���
�� 
errt � o   r s���� 0 t  ��  ��  ��   0   text format script     1 � � � (   t e x t   f o r m a t   s c r i p t   %  ��� � l  y { � � � � L   y { � � o   y z���� 0 script_object   � + %return the script, it is now loadable    � � � � J r e t u r n   t h e   s c r i p t ,   i t   i s   n o w   l o a d a b l e��  ��       �� � ���   � ���� 0 load_script   � ��  ���� � ����� 0 load_script  �� �� ���  �  ���� 0 apple_script_path  ��   � ������������������ 0 apple_script_path  �� 0 script_object  �� 0 script_text  �� 0 e  �� 0 n  �� 0 p  �� 0 f  �� 0 t   � ���� � 7�� ����� i�� k m���� � � � �������������
�� .sysoloadscpt        file��   � ������
�� 
errn���(��  
�� .rdwrread****        **** � ������
�� 
errn���\��  
�� 
as  
�� 
utf8
�� 
ret 
�� .sysodsct****        scpt�� 0 e   � ���� �
�� 
errn�� 0 n   � ���� �
�� 
ptlr�� 0 p   � ���� �
�� 
erob�� 0 f   � ������
�� 
errt�� 0 t  ��  
�� .sysodlogaskr        TEXT
�� 
errn
�� 
ptlr
�� 
erob
�� 
errt�� �� | �j  E�W mX  �E�O �j E�W X  ���l E�O ��%�%�%�%�%�%j E�W /X  �%a %�%a %j O)a �a �a �a �a �O� ascr  ��ޭ