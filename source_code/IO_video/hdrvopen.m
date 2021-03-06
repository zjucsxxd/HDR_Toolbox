function hdrv = hdrvopen(hdrv, permission)
%
%        hdrv = hdrvopen(hdrv)
%
%
%        Input:
%           -hdrv: a HDR video structure.
%           -permission: writing, 'w' value, or reading, 'r' value,
%           permissions.
%
%        Output:
%           -hdrv: a HDR video structure.
%
%        This function opens the video stream for reading frames
%
%     Copyright (C) 2013-15  Francesco Banterle
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
%

if(hdrv.streamOpen == 0) 
    hdrv.permission = permission;
    
    if(permission == 'w') 
        if((strfind(ldrv.type, 'TYPE_HDRV_LK08') == 1))
           open(ldrv.streamTMO);
           open(ldrv.streamR);
        end       

        if((strfind(ldrv.type, 'TYPE_HDRV_ZRB11') == 1))
           open(ldrv.stream);
        end              
        
        if((strfind(ldrv.type, 'TYPE_HDRV_MAI11') == 1))
           open(ldrv.streamTMO);
           open(ldrv.streamR);
        end             
    end    
    
    hdrv.streamOpen = 1;
end

end
