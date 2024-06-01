function data = readNPY(filename)
    fid = fopen(filename, 'rb');
    magicString = fread(fid, [1 6], 'uint8=>char');
    if ~strcmp(magicString, char([147, 'NUMPY']))
        error('Not a NPY file.');
    end

    majorVersion = fread(fid, 1, 'uint8');
    minorVersion = fread(fid, 1, 'uint8');
    headerLen = fread(fid, 1, 'uint16');
    header = fread(fid, [1 headerLen], 'uint8=>char');
    header = strrep(header, 'True', 'true');
    header = strrep(header, 'False', 'false');
    header = eval(header);
    
    dataType = header.descr;
    fortranOrder = header.fortran_order;
    shape = header.shape;
    
    % Convert numpy dtype to MATLAB dtype
    dataType = strrep(dataType, '>', '');
    dataType = strrep(dataType, '<', '');
    dataType = strrep(dataType, 'i1', 'int8');
    dataType = strrep(dataType, 'i2', 'int16');
    dataType = strrep(dataType, 'i4', 'int32');
    dataType = strrep(dataType, 'i8', 'int64');
    dataType = strrep(dataType, 'u1', 'uint8');
    dataType = strrep(dataType, 'u2', 'uint16');
    dataType = strrep(dataType, 'u4', 'uint32');
    dataType = strrep(dataType, 'u8', 'uint64');
    dataType = strrep(dataType, 'f4', 'single');
    dataType = strrep(dataType, 'f8', 'double');

    % Read data
    if fortranOrder
        data = fread(fid, prod(shape), ['*' dataType]);
        data = reshape(data, shape);
        data = permute(data, length(shape):-1:1);
    else
        data = fread(fid, prod(shape), ['*' dataType]);
        data = reshape(data, fliplr(shape));
        data = permute(data, length(shape):-1:1);
    end
    
    fclose(fid);
end