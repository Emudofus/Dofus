// Action script...

// [Initial MovieClip Action of sprite 860]
#initclip 72
class ank.battlefield.utils.Compressor extends ank.utils.Compressor
{
    function Compressor()
    {
        super();
    } // End of the function
    static function uncompressMap(mapID, name, width, height, backgroundNum, sData, oMap, bForced)
    {
        if (oMap == undefined)
        {
            return;
        } // end if
        var _loc4 = new Array();
        var _loc5 = sData.length;
        var _loc2;
        var _loc3 = 0;
        for (var _loc1 = 0; _loc1 < _loc5; _loc1 = _loc1 + 10)
        {
            _loc2 = ank.battlefield.utils.Compressor.uncompressCell(sData.substring(_loc1, _loc1 + 10), bForced, 0);
            _loc2.num = _loc3;
            _loc4.push(_loc2);
            ++_loc3;
        } // end of for
        oMap.id = Number(mapID);
        oMap.name = name;
        oMap.width = Number(width);
        oMap.height = Number(height);
        oMap.backgroundNum = backgroundNum;
        oMap.data = _loc4;
    } // End of the function
    static function uncompressCell(sData, bForced, nPermanentLevel)
    {
        if (bForced == undefined)
        {
            bForced = false;
        } // end if
        if (nPermanentLevel == undefined)
        {
            nPermanentLevel = 0;
        }
        else
        {
            nPermanentLevel = Number(nPermanentLevel);
        } // end else if
        var _loc3 = new ank.battlefield.datacenter.Cell();
        var _loc4 = sData.split("");
        var _loc2 = _loc4.length - 1;
        var _loc1 = new Array();
        while (_loc2 >= 0)
        {
            _loc1[_loc2] = ank.utils.Compressor._self._hashCodes[_loc4[_loc2]];
            --_loc2;
        } // end while
        _loc3.active = (_loc1[0] & 32) >> 5 ? (true) : (false);
        if (_loc3.active || bForced)
        {
            _loc3.nPermanentLevel = nPermanentLevel;
            _loc3.lineOfSight = _loc1[0] & 1 ? (true) : (false);
            _loc3.layerGroundRot = (_loc1[1] & 48) >> 4;
            _loc3.groundLevel = _loc1[1] & 15;
            _loc3.movement = (_loc1[2] & 56) >> 3;
            _loc3.layerGroundNum = ((_loc1[2] & 7) << 6) + _loc1[3];
            _loc3.groundSlope = (_loc1[4] & 60) >> 2;
            _loc3.layerGroundFlip = (_loc1[4] & 2) >> 1 ? (true) : (false);
            _loc3.layerObject1Num = ((_loc1[4] & 1) << 12) + (_loc1[5] << 6) + _loc1[6];
            _loc3.layerObject1Rot = (_loc1[7] & 48) >> 4;
            _loc3.layerObject1Flip = (_loc1[7] & 8) >> 3 ? (true) : (false);
            _loc3.layerObject2Flip = (_loc1[7] & 4) >> 2 ? (true) : (false);
            _loc3.layerObject2Interactive = (_loc1[7] & 2) >> 1 ? (true) : (false);
            _loc3.layerObject2Num = ((_loc1[7] & 1) << 12) + (_loc1[8] << 6) + _loc1[9];
            _loc3.layerObjectExternal = "";
            _loc3.layerObjectExternalInteractive = false;
        } // end if
        return (_loc3);
    } // End of the function
    static function compressMap(oMap)
    {
        if (oMap == undefined)
        {
            return;
        } // end if
        var _loc2 = new Array();
        var _loc3 = oMap.data;
        var _loc4 = _loc3.length;
        for (var _loc1 = 0; _loc1 < _loc4; ++_loc1)
        {
            _loc2.push(ank.battlefield.utils.Compressor.compressCell(_loc3[_loc1]));
        } // end of for
        return (_loc2.join(""));
    } // End of the function
    static function compressCell(oCell)
    {
        var _loc4;
        var _loc1 = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        _loc1[0] = (oCell.active ? (1) : (0)) << 5;
        _loc1[0] = _loc1[0] | (oCell.lineOfSight ? (1) : (0));
        _loc1[1] = (oCell.layerGroundRot & 3) << 4;
        _loc1[1] = _loc1[1] | oCell.groundLevel & 15;
        _loc1[2] = (oCell.movement & 7) << 3;
        _loc1[2] = _loc1[2] | oCell.layerGroundNum >> 6 & 7;
        _loc1[3] = oCell.layerGroundNum & 63;
        _loc1[4] = (oCell.groundSlope & 15) << 2;
        _loc1[4] = _loc1[4] | (oCell.layerGroundFlip ? (1) : (0)) << 1;
        _loc1[4] = _loc1[4] | oCell.layerGroundNum >> 12 & 1;
        _loc1[5] = oCell.layerObject1Num >> 6 & 63;
        _loc1[6] = oCell.layerObject1Num & 63;
        _loc1[7] = (oCell.layerObject1Rot & 3) << 4;
        _loc1[7] = _loc1[7] | (oCell.layerObject1Flip ? (1) : (0)) << 3;
        _loc1[7] = _loc1[7] | (oCell.layerObject2Flip ? (1) : (0)) << 2;
        _loc1[7] = _loc1[7] | (oCell.layerObject2Interactive ? (1) : (0)) << 1;
        _loc1[7] = _loc1[7] | oCell.layerObject2Num >> 12 & 1;
        _loc1[8] = oCell.layerObject2Num >> 6 & 63;
        _loc1[9] = oCell.layerObject2Num & 63;
        for (var _loc2 = _loc1.length - 1; _loc2 >= 0; --_loc2)
        {
            _loc1[_loc2] = ank.utils.Compressor.encode64(_loc1[_loc2]);
        } // end of for
        _loc4 = _loc1.join("");
        return (_loc4);
    } // End of the function
    static function compressPath(aFullPathData, bWithFirst)
    {
        var _loc3 = new String();
        var _loc7 = ank.battlefield.utils.Compressor.makeLightPath(aFullPathData, bWithFirst);
        var _loc2;
        var _loc1;
        var _loc6;
        var _loc5;
        var _loc4;
        var _loc8 = _loc7.length;
        for (var _loc2 = 0; _loc2 < _loc8; ++_loc2)
        {
            _loc1 = _loc7[_loc2];
            _loc6 = _loc1.dir & 7;
            _loc5 = (_loc1.num & 4032) >> 6;
            _loc4 = _loc1.num & 63;
            _loc3 = _loc3 + ank.utils.Compressor.encode64(_loc6);
            _loc3 = _loc3 + ank.utils.Compressor.encode64(_loc5);
            _loc3 = _loc3 + ank.utils.Compressor.encode64(_loc4);
        } // end of for
        return (_loc3);
    } // End of the function
    static function makeLightPath(aFullPath, bWithFirst)
    {
        if (aFullPath == undefined)
        {
            ank.utils.Logger.err("Le chemin est vide");
            return (new Array());
        } // end if
        var _loc4 = new Array();
        var _loc3;
        if (bWithFirst)
        {
            _loc4.push(aFullPath[0]);
        } // end if
        for (var _loc1 = aFullPath.length - 1; _loc1 >= 0; --_loc1)
        {
            if (aFullPath[_loc1].dir != _loc3)
            {
                _loc4.splice(0, 0, aFullPath[_loc1]);
                _loc3 = aFullPath[_loc1].dir;
            } // end if
        } // end of for
        return (_loc4);
    } // End of the function
    static function extractFullPath(mapHandler, compressedData)
    {
        var _loc6 = new Array();
        var _loc2 = compressedData.split("");
        var _loc1;
        var _loc7 = compressedData.length;
        var _loc8 = mapHandler.getCellCount();
        for (var _loc1 = 0; _loc1 < _loc7; _loc1 = _loc1 + 3)
        {
            _loc2[_loc1] = ank.utils.Compressor.decode64(_loc2[_loc1]);
            _loc2[_loc1 + 1] = ank.utils.Compressor.decode64(_loc2[_loc1 + 1]);
            _loc2[_loc1 + 2] = ank.utils.Compressor.decode64(_loc2[_loc1 + 2]);
            var _loc3 = (_loc2[_loc1 + 1] & 15) << 6 | _loc2[_loc1 + 2];
            if (_loc3 < 0)
            {
                ank.utils.Logger.err("Case pas sur carte");
                return (null);
            } // end if
            if (_loc3 > _loc8)
            {
                ank.utils.Logger.err("Case pas sur carte");
                return (null);
            } // end if
            _loc6.push({num: _loc3, dir: _loc2[_loc1]});
        } // end of for
        return (ank.battlefield.utils.Compressor.makeFullPath(mapHandler, _loc6));
    } // End of the function
    static function makeFullPath(mapHandler, aLightPath)
    {
        var _loc4 = new Array();
        var _loc2;
        var _loc5 = 0;
        var _loc10 = mapHandler.getWidth();
        var _loc9 = [1, _loc10, _loc10 * 2 - 1, _loc10 - 1, -1, -_loc10, -_loc10 * 2 + 1, -(_loc10 - 1)];
        _loc2 = aLightPath[0].num;
        _loc4[_loc5] = _loc2;
        for (var _loc1 = 1; _loc1 < aLightPath.length; ++_loc1)
        {
            var _loc3 = aLightPath[_loc1].num;
            var _loc7 = aLightPath[_loc1].dir;
            var _loc6 = 2 * _loc10 + 1;
            while (_loc4[_loc5] != _loc3)
            {
                _loc2 = _loc2 + _loc9[_loc7];
                _loc4[++_loc5] = _loc2;
                if (--_loc6 < 0)
                {
                    ank.utils.Logger.err("Chemin impossible");
                    return (null);
                } // end if
            } // end while
            _loc2 = _loc3;
        } // end of for
        return (_loc4);
    } // End of the function
} // End of Class
#endinitclip
