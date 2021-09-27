function BSCatalogData = ReadCatalog(filepath)
    arguments
        filepath = '../BSCatalog/BSCatalog.txt'
    end
    opts = delimitedTextImportOptions('DataLines',3,'Delimiter',' ','ConsecutiveDelimitersRule', 'join');
    BSCatalogData = readcell(filepath,opts);
    BSCatalogData(:,1) = [];
end