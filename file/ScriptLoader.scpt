FasdUAS 1.101.10   ��   ��    k             l     ��������  ��  ��        l     ��������  ��  ��     	 
 	 l     ��������  ��  ��   
     l     ��������  ��  ��        l      ��  ��   ��
 * Note: we use load_script to load plain-text .applescript files, which cant be loaded directly without this method
 * Note: we use .applescript instead of .scpt files because its easier to put plain text script files under version control like github
 * Note: You can load compiled scripts (.scpt) or plain text scripts (.applescript). Make sure, though, that your .applescript files are encoded as either Mac (what AppleScript Editor uses) UTF-8 (if you use another text editor). Any scripts loaded are expected to be installed into your Scripts directory. Use the line below to reference the script:
 * Remember to import this method before you use it with a property: 
 * Example: 
 * property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt")--prerequisite for loading .applescript files * property ListAsserter : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "list:ListAsserter.applescript"))  * my ListAsserter's equals_to({1, 2, 3, 4}, {1, 2, 3, 4})
 * if my ListAsserter's equals_to({1, 2, 3, 4}, {1, 2, 3, 4}) then *		log "yes" *	else *		log "no" *	end if
 * @Param: apple_script_path: is an "alias hsf file path"
      �  	� 
   *   N o t e :   w e   u s e   l o a d _ s c r i p t   t o   l o a d   p l a i n - t e x t   . a p p l e s c r i p t   f i l e s ,   w h i c h   c a n t   b e   l o a d e d   d i r e c t l y   w i t h o u t   t h i s   m e t h o d 
   *   N o t e :   w e   u s e   . a p p l e s c r i p t   i n s t e a d   o f   . s c p t   f i l e s   b e c a u s e   i t s   e a s i e r   t o   p u t   p l a i n   t e x t   s c r i p t   f i l e s   u n d e r   v e r s i o n   c o n t r o l   l i k e   g i t h u b 
   *   N o t e :   Y o u   c a n   l o a d   c o m p i l e d   s c r i p t s   ( . s c p t )   o r   p l a i n   t e x t   s c r i p t s   ( . a p p l e s c r i p t ) .   M a k e   s u r e ,   t h o u g h ,   t h a t   y o u r   . a p p l e s c r i p t   f i l e s   a r e   e n c o d e d   a s   e i t h e r   M a c   ( w h a t   A p p l e S c r i p t   E d i t o r   u s e s )   U T F - 8   ( i f   y o u   u s e   a n o t h e r   t e x t   e d i t o r ) .   A n y   s c r i p t s   l o a d e d   a r e   e x p e c t e d   t o   b e   i n s t a l l e d   i n t o   y o u r   S c r i p t s   d i r e c t o r y .   U s e   t h e   l i n e   b e l o w   t o   r e f e r e n c e   t h e   s c r i p t : 
   *   R e m e m b e r   t o   i m p o r t   t h i s   m e t h o d   b e f o r e   y o u   u s e   i t   w i t h   a   p r o p e r t y :   
   *   E x a m p l e :   
   *   p r o p e r t y   S c r i p t L o a d e r   :   l o a d   s c r i p t   a l i a s   ( ( p a t h   t o   s c r i p t s   f o l d e r   f r o m   u s e r   d o m a i n   a s   t e x t )   &   " f i l e : S c r i p t L o a d e r . s c p t " ) - - p r e r e q u i s i t e   f o r   l o a d i n g   . a p p l e s c r i p t   f i l e s    *   p r o p e r t y   L i s t A s s e r t e r   :   m y   S c r i p t L o a d e r ' s   l o a d _ s c r i p t ( a l i a s   ( ( p a t h   t o   s c r i p t s   f o l d e r   f r o m   u s e r   d o m a i n   a s   t e x t )   &   " l i s t : L i s t A s s e r t e r . a p p l e s c r i p t " ) )      *   m y   L i s t A s s e r t e r ' s   e q u a l s _ t o ( { 1 ,   2 ,   3 ,   4 } ,   { 1 ,   2 ,   3 ,   4 } ) 
   *   i f   m y   L i s t A s s e r t e r ' s   e q u a l s _ t o ( { 1 ,   2 ,   3 ,   4 } ,   { 1 ,   2 ,   3 ,   4 } )   t h e n    * 	 	 l o g   " y e s "    * 	 e l s e    * 	 	 l o g   " n o "    * 	 e n d   i f 
   *   @ P a r a m :   a p p l e _ s c r i p t _ p a t h :   i s   a n   " a l i a s   h s f   f i l e   p a t h " 
        i         I      �� ���� 0 load_script     ��  o      ���� 0 apple_script_path  ��  ��    k     {       Q     x     r    
    I   ��  ��
�� .sysoloadscpt        file   o    ���� 0 apple_script_path  ��    o      ���� 0 script_object    R      ���� !
�� .ascrerr ****      � ****��   ! �� "��
�� 
errn " d       # # m      �������    l   x $ % & $ k    x ' '  ( ) ( r     * + * m     , , � - -   + o      ���� 0 script_text   )  . / . Q    1 0 1 2 0 l     3 4 5 3 r      6 7 6 I   �� 8��
�� .rdwrread****        **** 8 o    ���� 0 apple_script_path  ��   7 o      ���� 0 script_text   4 ( " Try reading as Mac encoding first    5 � 9 9 D   T r y   r e a d i n g   a s   M a c   e n c o d i n g   f i r s t 1 R      ���� :
�� .ascrerr ****      � ****��   : �� ;��
�� 
errn ; d       < < m      �������   2 l  ( 1 = > ? = l  ( 1 @ A B @ r   ( 1 C D C I  ( /�� E F
�� .rdwrread****        **** E o   ( )���� 0 apple_script_path   F �� G��
�� 
as   G m   * +��
�� 
utf8��   D o      ���� 0 script_text   A   Finally try UTF-8    B � H H $   F i n a l l y   t r y   U T F - 8 > &   Error reading script's encoding    ? � I I @   E r r o r   r e a d i n g   s c r i p t ' s   e n c o d i n g /  J�� J Q   2 x K L M K r   5 H N O N I  5 F�� P��
�� .sysodsct****        scpt P l  5 B Q���� Q b   5 B R S R b   5 @ T U T b   5 > V W V b   5 < X Y X b   5 : Z [ Z b   5 8 \ ] \ m   5 6 ^ ^ � _ _  s c r i p t   s ] o   6 7��
�� 
ret  [ o   8 9���� 0 script_text   Y o   : ;��
�� 
ret  W m   < = ` ` � a a  e n d   s c r i p t   U o   > ?��
�� 
ret  S m   @ A b b � c c  r e t u r n   s��  ��  ��   O o      ���� 0 script_object   L R      �� d e
�� .ascrerr ****      � **** d o      ���� 0 e   e �� f g
�� 
errn f o      ���� 0 n   g �� h i
�� 
ptlr h o      ���� 0 p   i �� j k
�� 
erob j o      ���� 0 f   k �� l��
�� 
errt l o      ���� 0 t  ��   M k   P x m m  n o n I  P a�� p��
�� .sysodlogaskr        TEXT p b   P ] q r q b   P Y s t s b   P W u v u b   P S w x w m   P Q y y � z z , E r r o r   r e a d i n g   l i b r a r y   x o   Q R���� 0 apple_script_path   v m   S V { { � | |    t o   W X���� 0 e   r m   Y \ } } � ~ ~ : P l e a s e   e n c o d e   a s   M a c   o r   U T F - 8��   o  ��  R   b x�� � �
�� .ascrerr ****      � **** � o   v w���� 0 e   � �� � �
�� 
errn � o   f g���� 0 n   � �� � �
�� 
ptlr � o   j k���� 0 p   � �� � �
�� 
erob � o   n o���� 0 f   � �� ���
�� 
errt � o   r s���� 0 t  ��  ��  ��   %   text format script     & � � � (   t e x t   f o r m a t   s c r i p t     ��� � l  y { � � � � L   y { � � o   y z���� 0 script_object   � + %return the script, it is now loadable    � � � � J r e t u r n   t h e   s c r i p t ,   i t   i s   n o w   l o a d a b l e��     � � � l     ����� � I     �� ����� 0 load   �  � � � I   �� ���
�� .earsffdralis        afdr �  f    ��   �  � � � m     � � � � � , F i l e P a r s e r . a p p l e s c r i p t �  ��� � m    ��������  ��  ��  ��   �  � � � l      �� � ���   �
 * NOTE: this method is a little strange, it serves as a simple way to load script files relative to the position of the script that is loading it.
 * Example: property FileParser : ScriptLoader's load(path to me, "FileParser.applescript",-1)--loads the script
 * 
     � � � � 
   *   N O T E :   t h i s   m e t h o d   i s   a   l i t t l e   s t r a n g e ,   i t   s e r v e s   a s   a   s i m p l e   w a y   t o   l o a d   s c r i p t   f i l e s   r e l a t i v e   t o   t h e   p o s i t i o n   o f   t h e   s c r i p t   t h a t   i s   l o a d i n g   i t . 
   *   E x a m p l e :   p r o p e r t y   F i l e P a r s e r   :   S c r i p t L o a d e r ' s   l o a d ( p a t h   t o   m e ,   " F i l e P a r s e r . a p p l e s c r i p t " , - 1 ) - - l o a d s   t h e   s c r i p t 
   *   
   �  ��� � i     � � � I      �� ����� 0 load   �  � � � o      ���� 0 	hsf_alias   �  � � � o      ���� 0 	file_name   �  ��� � o      ���� 0 path_offset  ��  ��   � k     < � �  � � � r      � � � o     ���� 0 	hsf_alias   � o      ���� 0 the_offset_file_path   �  � � � Y    # ��� � ��� � k     � �  � � � I   �� ���
�� .ascrcmnt****      � **** � o    ���� 0 i  ��   �  ��� � r     � � � 4    �� �
�� 
alis � l    ����� � b     � � � l    ����� � c     � � � o    ���� 0 the_offset_file_path   � m    ��
�� 
ctxt��  ��   � m     � � � � �  : :��  ��   � o      ���� 0 the_offset_file_path  ��  �� 0 i   � o    ���� 0 path_offset   � m    	��������   �  � � � I  $ )�� ���
�� .ascrcmnt****      � **** � o   $ %���� 0 the_offset_file_path  ��   �  � � � l  * 1 � � � � r   * 1 � � � b   * / � � � l  * - ����� � c   * - � � � o   * +���� 0 the_offset_file_path   � m   + ,��
�� 
ctxt��  ��   � o   - .���� 0 	file_name   � o      ���� 0 the_file_path   � V Pcombines the path and the file name into "folder:sub_folder:file.txt" hsf format    � � � � � c o m b i n e s   t h e   p a t h   a n d   t h e   f i l e   n a m e   i n t o   " f o l d e r : s u b _ f o l d e r : f i l e . t x t "   h s f   f o r m a t �  ��� � l  2 < � � � � L   2 < � � I   2 ;�� ����� 0 load_script   �  �� � 4   3 7�~ �
�~ 
alis � o   5 6�}�} 0 the_file_path  �  ��   � g afinally makes the hsf_file path into an alias hsf file path and then calls the load_script method    � � � � � f i n a l l y   m a k e s   t h e   h s f _ f i l e   p a t h   i n t o   a n   a l i a s   h s f   f i l e   p a t h   a n d   t h e n   c a l l s   t h e   l o a d _ s c r i p t   m e t h o d��  ��       �| � � � ��|   � �{�z�y�{ 0 load_script  �z 0 load  
�y .aevtoappnull  �   � **** � �x �w�v � ��u�x 0 load_script  �w �t ��t  �  �s�s 0 apple_script_path  �v   � �r�q�p�o�n�m�l�k�r 0 apple_script_path  �q 0 script_object  �p 0 script_text  �o 0 e  �n 0 n  �m 0 p  �l 0 f  �k 0 t   � �j�i � ,�h ��g�f ^�e ` b�d�c � y { }�b�a�`�_�^�]
�j .sysoloadscpt        file�i   � �\�[�Z
�\ 
errn�[�(�Z  
�h .rdwrread****        **** � �Y�X�W
�Y 
errn�X�\�W  
�g 
as  
�f 
utf8
�e 
ret 
�d .sysodsct****        scpt�c 0 e   � �V�U �
�V 
errn�U 0 n   � �T�S �
�T 
ptlr�S 0 p   � �R�Q �
�R 
erob�Q 0 f   � �P�O�N
�P 
errt�O 0 t  �N  
�b .sysodlogaskr        TEXT
�a 
errn
�` 
ptlr
�_ 
erob
�^ 
errt�] �u | �j  E�W mX  �E�O �j E�W X  ���l E�O ��%�%�%�%�%�%j E�W /X  �%a %�%a %j O)a �a �a �a �a �O� � �M ��L�K � ��J�M 0 load  �L �I ��I  �  �H�G�F�H 0 	hsf_alias  �G 0 	file_name  �F 0 path_offset  �K   � �E�D�C�B�A�@�E 0 	hsf_alias  �D 0 	file_name  �C 0 path_offset  �B 0 the_offset_file_path  �A 0 i  �@ 0 the_file_path   � �?�>�= ��<
�? .ascrcmnt****      � ****
�> 
alis
�= 
ctxt�< 0 load_script  �J =�E�O �ikh �j  O*��&�%/E�[OY��O�j  O��&�%E�O**�/k+  � �; ��:�9 � ��8
�; .aevtoappnull  �   � **** � k      � �  ��7�7  �:  �9   �   � �6 ��5
�6 .earsffdralis        afdr�5 0 load  �8 *)j  �im+  ascr  ��ޭ