FasdUAS 1.101.10   ��   ��    k             l      ��  ��    1 +
 * Loads many scripts at a specific path
      � 	 	 V 
   *   L o a d s   m a n y   s c r i p t s   a t   a   s p e c i f i c   p a t h 
     
  
 i         I      �������� 0 	load_many  ��  ��    l     ��������  ��  ��        l      ��  ��    1 +
 * Loads many scripts at a relative path
      �   V 
   *   L o a d s   m a n y   s c r i p t s   a t   a   r e l a t i v e   p a t h 
        i        I      �������� 0 relative_load_many  ��  ��    l     ��������  ��  ��        l      ��  ��     
 *
      �   
 
   * 
        i        I      ��  ���� 0 load      ! " ! o      ���� 0 	hsf_alias   "  #�� # o      ���� 0 	file_name  ��  ��    k      $ $  % & % l     ' ( ) ' r      * + * b      , - , l     .���� . c      / 0 / o     ���� 0 	hsf_alias   0 m    ��
�� 
ctxt��  ��   - o    ���� 0 	file_name   + o      ���� 0 the_file_path   ( V Pcombines the path and the file name into "folder:sub_folder:file.txt" hsf format    ) � 1 1 � c o m b i n e s   t h e   p a t h   a n d   t h e   f i l e   n a m e   i n t o   " f o l d e r : s u b _ f o l d e r : f i l e . t x t "   h s f   f o r m a t &  2�� 2 l    3 4 5 3 L     6 6 I    �� 7���� 0 load_script   7  8�� 8 4   	 �� 9
�� 
alis 9 o    ���� 0 the_file_path  ��  ��   4 g afinally makes the hsf_file path into an alias hsf file path and then calls the load_script method    5 � : : � f i n a l l y   m a k e s   t h e   h s f _ f i l e   p a t h   i n t o   a n   a l i a s   h s f   f i l e   p a t h   a n d   t h e n   c a l l s   t h e   l o a d _ s c r i p t   m e t h o d��     ; < ; l      �� = >��   =��
 * Note: we use load_script to load plain-text .applescript files, which cant be loaded directly without this method
 * Note: we use .applescript instead of .scpt files because its easier to put plain text script files under version control like github
 * Note: You can load compiled scripts (.scpt) or plain text scripts (.applescript). Make sure, though, that your .applescript files are encoded as either Mac (what AppleScript Editor uses) UTF-8 (if you use another text editor). Any scripts loaded are expected to be installed into your Scripts directory. Use the line below to reference the script:
 * Remember to import this method before you use it with a property: 
 * Example: 
 * property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt")--prerequisite for loading .applescript files * property ListAsserter : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "list:ListAsserter.applescript"))  * my ListAsserter's equals_to({1, 2, 3, 4}, {1, 2, 3, 4})
 * if my ListAsserter's equals_to({1, 2, 3, 4}, {1, 2, 3, 4}) then *		log "yes" *	else *		log "no" *	end if
 * @Param: apple_script_path: is an "alias hsf file path"
     > � ? ?	� 
   *   N o t e :   w e   u s e   l o a d _ s c r i p t   t o   l o a d   p l a i n - t e x t   . a p p l e s c r i p t   f i l e s ,   w h i c h   c a n t   b e   l o a d e d   d i r e c t l y   w i t h o u t   t h i s   m e t h o d 
   *   N o t e :   w e   u s e   . a p p l e s c r i p t   i n s t e a d   o f   . s c p t   f i l e s   b e c a u s e   i t s   e a s i e r   t o   p u t   p l a i n   t e x t   s c r i p t   f i l e s   u n d e r   v e r s i o n   c o n t r o l   l i k e   g i t h u b 
   *   N o t e :   Y o u   c a n   l o a d   c o m p i l e d   s c r i p t s   ( . s c p t )   o r   p l a i n   t e x t   s c r i p t s   ( . a p p l e s c r i p t ) .   M a k e   s u r e ,   t h o u g h ,   t h a t   y o u r   . a p p l e s c r i p t   f i l e s   a r e   e n c o d e d   a s   e i t h e r   M a c   ( w h a t   A p p l e S c r i p t   E d i t o r   u s e s )   U T F - 8   ( i f   y o u   u s e   a n o t h e r   t e x t   e d i t o r ) .   A n y   s c r i p t s   l o a d e d   a r e   e x p e c t e d   t o   b e   i n s t a l l e d   i n t o   y o u r   S c r i p t s   d i r e c t o r y .   U s e   t h e   l i n e   b e l o w   t o   r e f e r e n c e   t h e   s c r i p t : 
   *   R e m e m b e r   t o   i m p o r t   t h i s   m e t h o d   b e f o r e   y o u   u s e   i t   w i t h   a   p r o p e r t y :   
   *   E x a m p l e :   
   *   p r o p e r t y   S c r i p t L o a d e r   :   l o a d   s c r i p t   a l i a s   ( ( p a t h   t o   s c r i p t s   f o l d e r   f r o m   u s e r   d o m a i n   a s   t e x t )   &   " f i l e : S c r i p t L o a d e r . s c p t " ) - - p r e r e q u i s i t e   f o r   l o a d i n g   . a p p l e s c r i p t   f i l e s    *   p r o p e r t y   L i s t A s s e r t e r   :   m y   S c r i p t L o a d e r ' s   l o a d _ s c r i p t ( a l i a s   ( ( p a t h   t o   s c r i p t s   f o l d e r   f r o m   u s e r   d o m a i n   a s   t e x t )   &   " l i s t : L i s t A s s e r t e r . a p p l e s c r i p t " ) )      *   m y   L i s t A s s e r t e r ' s   e q u a l s _ t o ( { 1 ,   2 ,   3 ,   4 } ,   { 1 ,   2 ,   3 ,   4 } ) 
   *   i f   m y   L i s t A s s e r t e r ' s   e q u a l s _ t o ( { 1 ,   2 ,   3 ,   4 } ,   { 1 ,   2 ,   3 ,   4 } )   t h e n    * 	 	 l o g   " y e s "    * 	 e l s e    * 	 	 l o g   " n o "    * 	 e n d   i f 
   *   @ P a r a m :   a p p l e _ s c r i p t _ p a t h :   i s   a n   " a l i a s   h s f   f i l e   p a t h " 
   <  @ A @ i     B C B I      �� D���� 0 load_script   D  E�� E o      ���� 0 apple_script_path  ��  ��   C k     { F F  G H G Q     x I J K I r    
 L M L I   �� N��
�� .sysoloadscpt        file N o    ���� 0 apple_script_path  ��   M o      ���� 0 script_object   J R      ���� O
�� .ascrerr ****      � ****��   O �� P��
�� 
errn P d       Q Q m      �������   K l   x R S T R k    x U U  V W V r     X Y X m     Z Z � [ [   Y o      ���� 0 script_text   W  \ ] \ Q    1 ^ _ ` ^ l     a b c a r      d e d I   �� f��
�� .rdwrread****        **** f o    ���� 0 apple_script_path  ��   e o      ���� 0 script_text   b ( " Try reading as Mac encoding first    c � g g D   T r y   r e a d i n g   a s   M a c   e n c o d i n g   f i r s t _ R      ���� h
�� .ascrerr ****      � ****��   h �� i��
�� 
errn i d       j j m      �������   ` l  ( 1 k l m k l  ( 1 n o p n r   ( 1 q r q I  ( /�� s t
�� .rdwrread****        **** s o   ( )���� 0 apple_script_path   t �� u��
�� 
as   u m   * +��
�� 
utf8��   r o      ���� 0 script_text   o   Finally try UTF-8    p � v v $   F i n a l l y   t r y   U T F - 8 l &   Error reading script's encoding    m � w w @   E r r o r   r e a d i n g   s c r i p t ' s   e n c o d i n g ]  x�� x Q   2 x y z { y r   5 H | } | I  5 F�� ~��
�� .sysodsct****        scpt ~ l  5 B ����  b   5 B � � � b   5 @ � � � b   5 > � � � b   5 < � � � b   5 : � � � b   5 8 � � � m   5 6 � � � � �  s c r i p t   s � o   6 7��
�� 
ret  � o   8 9���� 0 script_text   � o   : ;��
�� 
ret  � m   < = � � � � �  e n d   s c r i p t   � o   > ?��
�� 
ret  � m   @ A � � � � �  r e t u r n   s��  ��  ��   } o      ���� 0 script_object   z R      �� � �
�� .ascrerr ****      � **** � o      ���� 0 e   � �� � �
�� 
errn � o      ���� 0 n   � �� � �
�� 
ptlr � o      ���� 0 p   � �� � �
�� 
erob � o      ���� 0 f   � �� ���
�� 
errt � o      ���� 0 t  ��   { k   P x � �  � � � I  P a�� ���
�� .sysodlogaskr        TEXT � b   P ] � � � b   P Y � � � b   P W � � � b   P S � � � m   P Q � � � � � , E r r o r   r e a d i n g   l i b r a r y   � o   Q R���� 0 apple_script_path   � m   S V � � � � �    � o   W X���� 0 e   � m   Y \ � � � � � : P l e a s e   e n c o d e   a s   M a c   o r   U T F - 8��   �  ��� � R   b x�� � �
�� .ascrerr ****      � **** � o   v w���� 0 e   � �� � �
�� 
errn � o   f g���� 0 n   � �� � �
�� 
ptlr � o   j k���� 0 p   � �� � �
�� 
erob � o   n o���� 0 f   � �� ���
�� 
errt � o   r s���� 0 t  ��  ��  ��   S   text format script     T � � � (   t e x t   f o r m a t   s c r i p t   H  ��� � l  y { � � � � L   y { � � o   y z���� 0 script_object   � + %return the script, it is now loadable    � � � � J r e t u r n   t h e   s c r i p t ,   i t   i s   n o w   l o a d a b l e��   A  � � � l     ����� � I     �� ����� 0 load   �  � � � I   �� ���
�� .earsffdralis        afdr �  f    ��   �  � � � m     � � � � � , F i l e P a r s e r . a p p l e s c r i p t �  ��� � m    ��������  ��  ��  ��   �  � � � l      �� � ���   �MG
 * NOTE: this method is a little strange, it serves as a simple way to load script files relative to the position of the script that is loading it.
 * Example: property FileParser : ScriptLoader's load(path to me, "FileParser.applescript",-1)--loads the script
 * @PARAM: the path_offset is used to offset the path backwards
     � � � �� 
   *   N O T E :   t h i s   m e t h o d   i s   a   l i t t l e   s t r a n g e ,   i t   s e r v e s   a s   a   s i m p l e   w a y   t o   l o a d   s c r i p t   f i l e s   r e l a t i v e   t o   t h e   p o s i t i o n   o f   t h e   s c r i p t   t h a t   i s   l o a d i n g   i t . 
   *   E x a m p l e :   p r o p e r t y   F i l e P a r s e r   :   S c r i p t L o a d e r ' s   l o a d ( p a t h   t o   m e ,   " F i l e P a r s e r . a p p l e s c r i p t " , - 1 ) - - l o a d s   t h e   s c r i p t 
   *   @ P A R A M :   t h e   p a t h _ o f f s e t   i s   u s e d   t o   o f f s e t   t h e   p a t h   b a c k w a r d s 
   �  ��� � i     � � � I      �� ����� 0 relative_load   �  � � � o      ���� 0 	hsf_alias   �  � � � o      ���� 0 	file_name   �  ��� � o      ���� 0 path_offset  ��  ��   � k     % � �  � � � r      � � � o     ���� 0 	hsf_alias   � o      ���� 0 the_offset_file_path   �  � � � Y     ��� � ��� � k     � �  � � � l   �� � ���   �  log i    � � � � 
 l o g   i �  ��� � r     � � � 4    �� �
�� 
alis � l    ����� � b     � � � l    ���� � c     � � � o    �~�~ 0 the_offset_file_path   � m    �}
�} 
ctxt��  �   � m     � � � � �  : :��  ��   � o      �|�| 0 the_offset_file_path  ��  �� 0 i   � o    �{�{ 0 path_offset   � m    	�z�z����   �  � � � l   �y � ��y   �  log the_offset_file_path    � � � � 0 l o g   t h e _ o f f s e t _ f i l e _ p a t h �  ��x � I    %�w ��v�w 0 load   �  � � � o     �u�u 0 the_offset_file_path   �  ��t � o     !�s�s 0 	file_name  �t  �v  �x  ��       �r � � �r   � �q�p�o�n�m�l�q 0 	load_many  �p 0 relative_load_many  �o 0 load  �n 0 load_script  �m 0 relative_load  
�l .aevtoappnull  �   � **** � �k �j�i�h�k 0 	load_many  �j  �i      �h h  �g �f�e�d�g 0 relative_load_many  �f  �e      �d h �c �b�a	
�`�c 0 load  �b �_�_   �^�]�^ 0 	hsf_alias  �] 0 	file_name  �a  	 �\�[�Z�\ 0 	hsf_alias  �[ 0 	file_name  �Z 0 the_file_path  
 �Y�X�W
�Y 
ctxt
�X 
alis�W 0 load_script  �` ��&�%E�O**�/k+  �V C�U�T�S�V 0 load_script  �U �R�R   �Q�Q 0 apple_script_path  �T   �P�O�N�M�L�K�J�I�P 0 apple_script_path  �O 0 script_object  �N 0 script_text  �M 0 e  �L 0 n  �K 0 p  �J 0 f  �I 0 t   �H�G Z�F�E�D ��C � ��B�A � � ��@�?�>�=�<�;
�H .sysoloadscpt        file�G   �:�9�8
�: 
errn�9�(�8  
�F .rdwrread****        **** �7�6�5
�7 
errn�6�\�5  
�E 
as  
�D 
utf8
�C 
ret 
�B .sysodsct****        scpt�A 0 e   �4�3
�4 
errn�3 0 n   �2�1
�2 
ptlr�1 0 p   �0�/
�0 
erob�/ 0 f   �.�-�,
�. 
errt�- 0 t  �,  
�@ .sysodlogaskr        TEXT
�? 
errn
�> 
ptlr
�= 
erob
�< 
errt�; �S | �j  E�W mX  �E�O �j E�W X  ���l E�O ��%�%�%�%�%�%j E�W /X  �%a %�%a %j O)a �a �a �a �a �O� �+ ��*�)�(�+ 0 relative_load  �* �'�'   �&�%�$�& 0 	hsf_alias  �% 0 	file_name  �$ 0 path_offset  �)   �#�"�!� ��# 0 	hsf_alias  �" 0 	file_name  �! 0 path_offset  �  0 the_offset_file_path  � 0 i   �� ��
� 
alis
� 
ctxt� 0 load  �( &�E�O �ikh *��&�%/E�[OY��O*��l+  ����
� .aevtoappnull  �   � **** k       ���  �  �     � ��
� .earsffdralis        afdr� 0 load  � *)j  �im+ ascr  ��ޭ