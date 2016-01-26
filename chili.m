function data = chili(html)
% CHILI extract information from html like searching for meat in your chili
%
% data = chili(urlread('www.mathworks.com'));
%
%

% Translate ASCII HTML into char they represent
html = regexprep(html,'<br>',char(13));
html = removeAccent(html);
html = removeExplicitChar(html);

% Get all href in the doc
[href,idxhref]=regexp(html,'<a href="([^"]*)"','tokens');

%html = regexprep(html,'<a href.*?/a>','');
cat = repmat({'href'},length(idxhref),1);

% If the HTML has a doc type of structure they may use H leveling so
% extract this information from the page
[h,cath,idxh]=extractHeadings(html);
cat = {cat{:},cath{:}}';
idxval=[idxhref,idxh]';
val = {href{:},h{:}}';

% Extract the scripts
% [scripts,scriptcat,idxscripts]=extracttag(html,'script');
% cat = {cat{:},scriptcat{:}}';
% idxval = [idxval',idxscripts]';
% val = {val{:}, scripts{:}}';

% Add title
[title,titlecat,idxtitle]=extracttag(html,'title');
cat = {cat{:},titlecat{:}}';
idxval = [idxval',idxtitle]';
val = {val{:}, title{:}}';

for idx=1:length(idxval)
    val{idx} = regexprep(val{idx},'<[^>]*>',''); % Remove Tags and Attributes
    val{idx} = regexprep(val{idx},'[<>]*',''); % remove special characters
    val{idx} = regexprep(val{idx},['[',char(13),char(10),']*'],''); % Remove Charage Return and Line Feed
    val{idx} = regexprep(val{idx},'  ',' '); % Replace multiple space with single
    val{idx} = strtrim(val{idx}); % Remove leading space
end
cat = categorical(cat);
data=table(cat,val,idxval,'VariableNames',{'cat','val','index'});
data=sortrows(data,'index');

end

function [matchVal,cat,idxVal]=extractHeadings(str)

[matchVal,tokenVal,idxVal]=regexp(str,'<(h\d).*?/(\1)>','match','tokens');
cat = cell(length(idxVal),1);
for idx = 1:length(idxVal)
        cat{idx}=tokenVal{idx}{1};
end
end

function [matchVal,cat,idxVal]=extracttag(str,tag)
% Pull tag out
[matchVal,idxVal]=regexp(str,['<',tag,'.*?/',tag,'>'],'match');
cat = repmat({tag},length(idxVal),1);
end

function newStr = removeAccent(str)
newStr = regexprep(str,'&Aacute;','�');
newStr = regexprep(newStr,'&aacute;','�');
newStr = regexprep(newStr,'&Agrave;','�');
newStr = regexprep(newStr,'&Acirc;','�');
newStr = regexprep(newStr,'&agrave;','�');
newStr = regexprep(newStr,'&Acirc;','�');
newStr = regexprep(newStr,'&acirc;','�');
newStr = regexprep(newStr,'&Auml;','�');
newStr = regexprep(newStr,'&auml;','�');
newStr = regexprep(newStr,'&Atilde;','�');
newStr = regexprep(newStr,'&atilde;','�');
newStr = regexprep(newStr,'&Aring;','�');
newStr = regexprep(newStr,'&aring;','�');
newStr = regexprep(newStr,'&Aelig;','�');
newStr = regexprep(newStr,'&aelig;','�');
newStr = regexprep(newStr,'&Ccedil;','�');
newStr = regexprep(newStr,'&ccedil;','�');
newStr = regexprep(newStr,'&Eth;','�');
newStr = regexprep(newStr,'&eth;','�');
newStr = regexprep(newStr,'&Eacute;','�');
newStr = regexprep(newStr,'&eacute;','�');
newStr = regexprep(newStr,'&Egrave;','�');
newStr = regexprep(newStr,'&egrave;','�');
newStr = regexprep(newStr,'&Ecirc;','�');
newStr = regexprep(newStr,'&ecirc;','�');
newStr = regexprep(newStr,'&Euml;','�');
newStr = regexprep(newStr,'&euml;','�');
newStr = regexprep(newStr,'&Iacute;','�');
newStr = regexprep(newStr,'&iacute;','�');
newStr = regexprep(newStr,'&Igrave;','�');
newStr = regexprep(newStr,'&igrave;','�');
newStr = regexprep(newStr,'&Icirc;','�');
newStr = regexprep(newStr,'&icirc;','�');
newStr = regexprep(newStr,'&Iuml;','�');
newStr = regexprep(newStr,'&iuml;','�');
newStr = regexprep(newStr,'&Ntilde;','�');
newStr = regexprep(newStr,'&ntilde;','�');
newStr = regexprep(newStr,'&Oacute;','�');
newStr = regexprep(newStr,'&oacute;','�');
newStr = regexprep(newStr,'&Ograve;','�');
newStr = regexprep(newStr,'&ograve;','�');
newStr = regexprep(newStr,'&Ocirc;','�');
newStr = regexprep(newStr,'&ocirc;','�');
newStr = regexprep(newStr,'&Ouml;','�');
newStr = regexprep(newStr,'&ouml;','�');
newStr = regexprep(newStr,'&Otilde;','�');
newStr = regexprep(newStr,'&otilde;','�');
newStr = regexprep(newStr,'&Oslash;','�');
newStr = regexprep(newStr,'&oslash;','�');
newStr = regexprep(newStr,'&szlig;','�');
newStr = regexprep(newStr,'&Thorn;','�');
newStr = regexprep(newStr,'&thorn;','�');
newStr = regexprep(newStr,'&Uacute;','�');
newStr = regexprep(newStr,'&uacute;','�');
newStr = regexprep(newStr,'&Ugrave;','�');
newStr = regexprep(newStr,'&ugrave;','�');
newStr = regexprep(newStr,'&Ucirc;','�');
newStr = regexprep(newStr,'&ucirc;','�');
newStr = regexprep(newStr,'&Uuml;','�');
newStr = regexprep(newStr,'&uuml;','�');
newStr = regexprep(newStr,'&Yacute;','�');
newStr = regexprep(newStr,'&yacute;','�');
newStr = regexprep(newStr,'&yuml;','�');
newStr = regexprep(newStr,'&copy;','�');
newStr = regexprep(newStr,'&reg;','�');
newStr = regexprep(newStr,'&trade;','�');
newStr = regexprep(newStr,'&amp;','&');
newStr = regexprep(newStr,'&lt;','<');
newStr = regexprep(newStr,'&gt;','>');
newStr = regexprep(newStr,'&euro;','�');
newStr = regexprep(newStr,'&cent;','��');
newStr = regexprep(newStr,'&pound;','��');
newStr = regexprep(newStr,'&quot;','"');
newStr = regexprep(newStr,'&lsquo;','�');
newStr = regexprep(newStr,'&rsquo;','�');
newStr = regexprep(newStr,'&ldquo;','�');
newStr = regexprep(newStr,'&rdquo;','�');
newStr = regexprep(newStr,'&laquo;','�');
newStr = regexprep(newStr,'&raquo;','�');
newStr = regexprep(newStr,'&mdash;','�');
newStr = regexprep(newStr,'&ndash;','�');
newStr = regexprep(newStr,'&deg;','�');
newStr = regexprep(newStr,'&plusmn;','�');
newStr = regexprep(newStr,'&frac14;','�');
newStr = regexprep(newStr,'&frac12;','�');
newStr = regexprep(newStr,'&frac34;','�');
newStr = regexprep(newStr,'&times;','�');
newStr = regexprep(newStr,'&divide;','�');
newStr = regexprep(newStr,'&alpha;','?');
newStr = regexprep(newStr,'&beta;','?');
newStr = regexprep(newStr,'&infin;','?');
newStr = regexprep(newStr,'&nbsp;',' ');
newStr = regexprep(newStr,'&hearts;','&#10084;');

end

function str = removeExplicitChar(str)
% Sometimes people encode special characters using &#(number);
numStr = regexp(str,'&#(\d+);','tokens');
for idx = 1:length(numStr)
    specNum = numStr{idx};
    str = regexprep(str,['&#',specNum{1},';'],char(str2double(specNum{1})));
end

end

function [meta,newval] = extractval(val)

newval = cell(length(val),1);
meta = cell(length(val),1);

for idx=1:length(val)
    workVal = val{idx};
%     if workVal(4)=='>'
%         newval{idx}=workVal(5:end-6);
%         meta{idx}={};
%     else
        startIdx = find(workVal=='<');
        endIdx = find(workVal=='>');
        x=sort([startIdx,endIdx]);
        newval{idx}=workVal(x(floor(length(x)/2))+1:x(floor(length(x)/2)+1)-1);
        meta{idx}=regexp(workVal,' (?<class>[\w\s]*)="(?<val>[^"]*)"','tokens');
        
%     end
   
end

end

% load('.\data\metadata.mat');
% N = height(data);
% 
% schoollist = table;
% 
% for idx = 1:N
%     html = fileread(['.\data\',data.filename{idx}]);
%     htmlData = readHTML(html);
%     if verbose
%         disp(['Working on ',num2str(idx),' of ' num2str(N),' pages. ',htmlData.University{1}])
%     end
%     schoollist(idx,:)=htmlData;
%     data.processed(idx)=1;
% end
% end
%     function data=readHTML(html)
