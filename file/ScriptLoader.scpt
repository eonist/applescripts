FasdUAS 1.101.10   ��   ��    k             l     ����  I    �� ��
�� .ascrcmnt****      � ****  I     �� 	���� 0 	load_many   	  
�� 
 4    �� 
�� 
alis  l    ����  b        l   
 ����  I   
��  
�� .earsffdralis        afdr   f      �� ��
�� 
rtyp  m    ��
�� 
ctxt��  ��  ��    m   
    �    : :��  ��  ��  ��  ��  ��  ��        l     ��������  ��  ��        l     ��  ��    &  test if you can do path to home?     �   @ t e s t   i f   y o u   c a n   d o   p a t h   t o   h o m e ?      l      ��  ��    1 +
 * Loads many scripts at a specific path
      �     V 
   *   L o a d s   m a n y   s c r i p t s   a t   a   s p e c i f i c   p a t h 
     ! " ! i      # $ # I      �� %���� 0 	load_many   %  &�� & o      ���� 0 
the_folder  ��  ��   $ k      ' '  ( ) ( O      * + * l    , - . , r     / 0 / 6    1 2 1 n    
 3 4 3 2    
��
�� 
docf 4 4    �� 5
�� 
cfol 5 o    ���� 0 
the_folder   2 l    6���� 6 =    7 8 7 1    ��
�� 
kind 8 m     9 9 � : :   A p p l e S c r i p t   t e x t��  ��   0 o      ���� 0 the_file_list   -    or kind is "AppleScript"     . � ; ; 4   o r   k i n d   i s   " A p p l e S c r i p t "   + m      < <�                                                                                  MACS  alis    t  Macintosh HD               Ё��H+    
Finder.app                                                      X��B��        ����  	                CoreServices    Ё{�      �B�         �   �  6Macintosh HD:System: Library: CoreServices: Finder.app   
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��   )  = > = L     ? ? o    ���� 0 the_file_list   >  @ A @ l   �� B C��   B  get files in a folder    C � D D * g e t   f i l e s   i n   a   f o l d e r A  E F E l   �� G H��   G @ :get extension for each file and make sure its .applescript    H � I I t g e t   e x t e n s i o n   f o r   e a c h   f i l e   a n d   m a k e   s u r e   i t s   . a p p l e s c r i p t F  J K J l   �� L M��   L B <make a note that it can also support .scpt in a later update    M � N N x m a k e   a   n o t e   t h a t   i t   c a n   a l s o   s u p p o r t   . s c p t   i n   a   l a t e r   u p d a t e K  O�� O l   ��������  ��  ��  ��   "  P Q P l      �� R S��   R 1 +
 * Loads many scripts at a relative path
     S � T T V 
   *   L o a d s   m a n y   s c r i p t s   a t   a   r e l a t i v e   p a t h 
   Q  U V U i     W X W I      �������� 0 relative_load_many  ��  ��   X l     �� Y Z��   Y 1 +same as load_many, but with a relative path    Z � [ [ V s a m e   a s   l o a d _ m a n y ,   b u t   w i t h   a   r e l a t i v e   p a t h V  \ ] \ l      �� ^ _��   ^  
 *
     _ � ` ` 
 
   * 
   ]  a b a i     c d c I      �� e���� 0 load   e  f g f o      ���� 0 	hsf_alias   g  h�� h o      ���� 0 	file_name  ��  ��   d k      i i  j k j l     l m n l r      o p o b      q r q l     s���� s c      t u t o     ���� 0 	hsf_alias   u m    ��
�� 
ctxt��  ��   r o    ���� 0 	file_name   p o      ���� 0 the_file_path   m V Pcombines the path and the file name into "folder:sub_folder:file.txt" hsf format    n � v v � c o m b i n e s   t h e   p a t h   a n d   t h e   f i l e   n a m e   i n t o   " f o l d e r : s u b _ f o l d e r : f i l e . t x t "   h s f   f o r m a t k  w�� w l    x y z x L     { { I    �� |���� 0 load_script   |  }�� } 4   	 �� ~
�� 
alis ~ o    ���� 0 the_file_path  ��  ��   y g afinally makes the hsf_file path into an alias hsf file path and then calls the load_script method    z �   � f i n a l l y   m a k e s   t h e   h s f _ f i l e   p a t h   i n t o   a n   a l i a s   h s f   f i l e   p a t h   a n d   t h e n   c a l l s   t h e   l o a d _ s c r i p t   m e t h o d��   b  � � � l      �� � ���   ���
 * Note: we use load_script to load plain-text .applescript files, which cant be loaded directly without this method
 * Note: we use .applescript instead of .scpt files because its easier to put plain text script files under version control like github
 * Note: You can load compiled scripts (.scpt) or plain text scripts (.applescript). Make sure, though, that your .applescript files are encoded as either Mac (what AppleScript Editor uses) UTF-8 (if you use another text editor). Any scripts loaded are expected to be installed into your Scripts directory. Use the line below to reference the script:
 * Remember to import this method before you use it with a property: 
 * Example: 
 * property ScriptLoader : load script alias ((path to scripts folder from user domain as text) & "file:ScriptLoader.scpt")--prerequisite for loading .applescript files * property ListAsserter : my ScriptLoader's load_script(alias ((path to scripts folder from user domain as text) & "list:ListAsserter.applescript"))  * my ListAsserter's equals_to({1, 2, 3, 4}, {1, 2, 3, 4})
 * if my ListAsserter's equals_to({1, 2, 3, 4}, {1, 2, 3, 4}) then *		log "yes" *	else *		log "no" *	end if
 * @Param: apple_script_path: is an "alias hsf file path"
     � � � �	� 
   *   N o t e :   w e   u s e   l o a d _ s c r i p t   t o   l o a d   p l a i n - t e x t   . a p p l e s c r i p t   f i l e s ,   w h i c h   c a n t   b e   l o a d e d   d i r e c t l y   w i t h o u t   t h i s   m e t h o d 
   *   N o t e :   w e   u s e   . a p p l e s c r i p t   i n s t e a d   o f   . s c p t   f i l e s   b e c a u s e   i t s   e a s i e r   t o   p u t   p l a i n   t e x t   s c r i p t   f i l e s   u n d e r   v e r s i o n   c o n t r o l   l i k e   g i t h u b 
   *   N o t e :   Y o u   c a n   l o a d   c o m p i l e d   s c r i p t s   ( . s c p t )   o r   p l a i n   t e x t   s c r i p t s   ( . a p p l e s c r i p t ) .   M a k e   s u r e ,   t h o u g h ,   t h a t   y o u r   . a p p l e s c r i p t   f i l e s   a r e   e n c o d e d   a s   e i t h e r   M a c   ( w h a t   A p p l e S c r i p t   E d i t o r   u s e s )   U T F - 8   ( i f   y o u   u s e   a n o t h e r   t e x t   e d i t o r ) .   A n y   s c r i p t s   l o a d e d   a r e   e x p e c t e d   t o   b e   i n s t a l l e d   i n t o   y o u r   S c r i p t s   d i r e c t o r y .   U s e   t h e   l i n e   b e l o w   t o   r e f e r e n c e   t h e   s c r i p t : 
   *   R e m e m b e r   t o   i m p o r t   t h i s   m e t h o d   b e f o r e   y o u   u s e   i t   w i t h   a   p r o p e r t y :   
   *   E x a m p l e :   
   *   p r o p e r t y   S c r i p t L o a d e r   :   l o a d   s c r i p t   a l i a s   ( ( p a t h   t o   s c r i p t s   f o l d e r   f r o m   u s e r   d o m a i n   a s   t e x t )   &   " f i l e : S c r i p t L o a d e r . s c p t " ) - - p r e r e q u i s i t e   f o r   l o a d i n g   . a p p l e s c r i p t   f i l e s    *   p r o p e r t y   L i s t A s s e r t e r   :   m y   S c r i p t L o a d e r ' s   l o a d _ s c r i p t ( a l i a s   ( ( p a t h   t o   s c r i p t s   f o l d e r   f r o m   u s e r   d o m a i n   a s   t e x t )   &   " l i s t : L i s t A s s e r t e r . a p p l e s c r i p t " ) )      *   m y   L i s t A s s e r t e r ' s   e q u a l s _ t o ( { 1 ,   2 ,   3 ,   4 } ,   { 1 ,   2 ,   3 ,   4 } ) 
   *   i f   m y   L i s t A s s e r t e r ' s   e q u a l s _ t o ( { 1 ,   2 ,   3 ,   4 } ,   { 1 ,   2 ,   3 ,   4 } )   t h e n    * 	 	 l o g   " y e s "    * 	 e l s e    * 	 	 l o g   " n o "    * 	 e n d   i f 
   *   @ P a r a m :   a p p l e _ s c r i p t _ p a t h :   i s   a n   " a l i a s   h s f   f i l e   p a t h " 
   �  � � � i     � � � I      �� ����� 0 load_script   �  ��� � o      ���� 0 apple_script_path  ��  ��   � k     { � �  � � � Q     x � � � � r    
 � � � I   �� ���
�� .sysoloadscpt        file � o    ���� 0 apple_script_path  ��   � o      ���� 0 script_object   � R      ���� �
�� .ascrerr ****      � ****��   � �� ���
�� 
errn � d       � � m      �������   � l   x � � � � k    x � �  � � � r     � � � m     � � � � �   � o      ���� 0 script_text   �  � � � Q    1 � � � � l     � � � � r      � � � I   �� ���
�� .rdwrread****        **** � o    ���� 0 apple_script_path  ��   � o      ���� 0 script_text   � ( " Try reading as Mac encoding first    � � � � D   T r y   r e a d i n g   a s   M a c   e n c o d i n g   f i r s t � R      ���� �
�� .ascrerr ****      � ****��   � �� ���
�� 
errn � d       � � m      �������   � l  ( 1 � � � � l  ( 1 � � � � r   ( 1 � � � I  ( /�� � �
�� .rdwrread****        **** � o   ( )���� 0 apple_script_path   � �� ���
�� 
as   � m   * +��
�� 
utf8��   � o      ���� 0 script_text   �   Finally try UTF-8    � � � � $   F i n a l l y   t r y   U T F - 8 � &   Error reading script's encoding    � � � � @   E r r o r   r e a d i n g   s c r i p t ' s   e n c o d i n g �  ��� � Q   2 x � � � � r   5 H � � � I  5 F�� ���
�� .sysodsct****        scpt � l  5 B ����� � b   5 B � � � b   5 @ � � � b   5 > � � � b   5 < � � � b   5 : � � � b   5 8 � � � m   5 6 � � � � �  s c r i p t   s � o   6 7��
�� 
ret  � o   8 9���� 0 script_text   � o   : ;��
�� 
ret  � m   < = � � � � �  e n d   s c r i p t   � o   > ?��
�� 
ret  � m   @ A � � � � �  r e t u r n   s��  ��  ��   � o      ���� 0 script_object   � R      �� � �
�� .ascrerr ****      � **** � o      ���� 0 e   � �� � �
�� 
errn � o      ���� 0 n   � �� � �
�� 
ptlr � o      ���� 0 p   � �� � �
�� 
erob � o      ���� 0 f   � �� ���
�� 
errt � o      ���� 0 t  ��   � k   P x � �  � � � I  P a�� ���
�� .sysodlogaskr        TEXT � b   P ] � � � b   P Y � � � b   P W � � � b   P S � � � m   P Q � � � � � , E r r o r   r e a d i n g   l i b r a r y   � o   Q R���� 0 apple_script_path   � m   S V � � � � �    � o   W X���� 0 e   � m   Y \ � � � � � : P l e a s e   e n c o d e   a s   M a c   o r   U T F - 8��   �  ��� � R   b x�� � �
�� .ascrerr ****      � **** � o   v w���� 0 e   � �� � �
�� 
errn � o   f g���� 0 n   � �� � �
�� 
ptlr � o   j k���� 0 p   � �� � �
�� 
erob � o   n o���� 0 f   � � ��~
� 
errt � o   r s�}�} 0 t  �~  ��  ��   �   text format script     � � � � (   t e x t   f o r m a t   s c r i p t   �  ��| � l  y { � �  � L   y { o   y z�{�{ 0 script_object   � + %return the script, it is now loadable     � J r e t u r n   t h e   s c r i p t ,   i t   i s   n o w   l o a d a b l e�|   �  l     �z�y�x�z  �y  �x    l      �w�w  �{
 * NOTE: this method is a little strange, it serves as a simple way to load script files relative to the position of the script that is loading it.
 * Example: property FileParser : ScriptLoader's load(path to me, "FileParser.applescript",-1)--loads the script
 * @PARAM: the path_offset is used to offset the path backwards
 * --load(path to me, "FileParser.applescript", -1)
     �		� 
   *   N O T E :   t h i s   m e t h o d   i s   a   l i t t l e   s t r a n g e ,   i t   s e r v e s   a s   a   s i m p l e   w a y   t o   l o a d   s c r i p t   f i l e s   r e l a t i v e   t o   t h e   p o s i t i o n   o f   t h e   s c r i p t   t h a t   i s   l o a d i n g   i t . 
   *   E x a m p l e :   p r o p e r t y   F i l e P a r s e r   :   S c r i p t L o a d e r ' s   l o a d ( p a t h   t o   m e ,   " F i l e P a r s e r . a p p l e s c r i p t " , - 1 ) - - l o a d s   t h e   s c r i p t 
   *   @ P A R A M :   t h e   p a t h _ o f f s e t   i s   u s e d   t o   o f f s e t   t h e   p a t h   b a c k w a r d s 
   *   - - l o a d ( p a t h   t o   m e ,   " F i l e P a r s e r . a p p l e s c r i p t " ,   - 1 ) 
   
�v
 i     I      �u�t�u 0 relative_load    o      �s�s 0 	hsf_alias    o      �r�r 0 	file_name   �q o      �p�p 0 path_offset  �q  �t   k     %  r      o     �o�o 0 	hsf_alias   o      �n�n 0 the_offset_file_path    Y    �m�l k      l   �k !�k     log i   ! �"" 
 l o g   i #�j# r    $%$ 4    �i&
�i 
alis& l   '�h�g' b    ()( l   *�f�e* c    +,+ o    �d�d 0 the_offset_file_path  , m    �c
�c 
ctxt�f  �e  ) m    -- �..  : :�h  �g  % o      �b�b 0 the_offset_file_path  �j  �m 0 i   o    �a�a 0 path_offset   m    	�`�`���l   /0/ l   �_12�_  1  log the_offset_file_path   2 �33 0 l o g   t h e _ o f f s e t _ f i l e _ p a t h0 4�^4 I    %�]5�\�] 0 load  5 676 o     �[�[ 0 the_offset_file_path  7 8�Z8 o     !�Y�Y 0 	file_name  �Z  �\  �^  �v       �X9:;<=>?�X  9 �W�V�U�T�S�R�W 0 	load_many  �V 0 relative_load_many  �U 0 load  �T 0 load_script  �S 0 relative_load  
�R .aevtoappnull  �   � ****: �Q $�P�O@A�N�Q 0 	load_many  �P �MB�M B  �L�L 0 
the_folder  �O  @ �K�J�K 0 
the_folder  �J 0 the_file_list  A  <�I�HC�G 9
�I 
cfol
�H 
docfC  
�G 
kind�N � *�/�-�[�,\Z�81E�UO�OP; �F X�E�DDE�C�F 0 relative_load_many  �E  �D  D  E  �C h< �B d�A�@FG�?�B 0 load  �A �>H�> H  �=�<�= 0 	hsf_alias  �< 0 	file_name  �@  F �;�:�9�; 0 	hsf_alias  �: 0 	file_name  �9 0 the_file_path  G �8�7�6
�8 
ctxt
�7 
alis�6 0 load_script  �? ��&�%E�O**�/k+ = �5 ��4�3IJ�2�5 0 load_script  �4 �1K�1 K  �0�0 0 apple_script_path  �3  I �/�.�-�,�+�*�)�(�/ 0 apple_script_path  �. 0 script_object  �- 0 script_text  �, 0 e  �+ 0 n  �* 0 p  �) 0 f  �( 0 t  J �'�&L ��%M�$�# ��" � ��!� N � � �������
�' .sysoloadscpt        file�&  L ���
� 
errn��(�  
�% .rdwrread****        ****M ���
� 
errn��\�  
�$ 
as  
�# 
utf8
�" 
ret 
�! .sysodsct****        scpt�  0 e  N ��O
� 
errn� 0 n  O ��P
� 
ptlr� 0 p  P ��Q
� 
erob� 0 f  Q ���
� 
errt� 0 t  �  
� .sysodlogaskr        TEXT
� 
errn
� 
ptlr
� 
erob
� 
errt� �2 | �j  E�W mX  �E�O �j E�W X  ���l E�O ��%�%�%�%�%�%j E�W /X  �%a %�%a %j O)a �a �a �a �a �O�> �
�	�RS��
 0 relative_load  �	 �T� T  ���� 0 	hsf_alias  � 0 	file_name  � 0 path_offset  �  R ��� ����� 0 	hsf_alias  � 0 	file_name  �  0 path_offset  �� 0 the_offset_file_path  �� 0 i  S ����-��
�� 
alis
�� 
ctxt�� 0 load  � &�E�O �ikh *��&�%/E�[OY��O*��l+ ? ��U����VW��
�� .aevtoappnull  �   � ****U k     XX  ����  ��  ��  V  W �������� ����
�� 
alis
�� 
rtyp
�� 
ctxt
�� .earsffdralis        afdr�� 0 	load_many  
�� .ascrcmnt****      � ****�� **�)��l �%/k+ j  ascr  ��ޭ