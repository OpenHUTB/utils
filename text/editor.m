hFig = figure();
jCodePane = com.mathworks.widgets.SyntaxTextPane;
codeType = com.mathworks.widgets.text.mcode.MLanguage.M_MIME_TYPE;
jCodePane.setContentType(codeType)
jCodePane.setText('')
jScrollPane = com.mathworks.mwswing.MJScrollPane(jCodePane);
[jhPanel,hContainer] = javacomponent(jScrollPane,[10,10,300,100],hFig);
hContainer.Units = 'normalized';
hContainer.Position = [0 0 1 1];