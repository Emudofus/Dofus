// Action script...

// [Initial MovieClip Action of sprite 20809]
#initclip 74
if (!ank.battlefield.utils.Compressor)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    if (!ank.battlefield.utils)
    {
        _global.ank.battlefield.utils = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.utils.Compressor = function ()
    {
        super();
    }).prototype;
    (_global.ank.battlefield.utils.Compressor = function ()
    {
        super();
    }).uncompressMap = function (mapID, name, width, height, backgroundNum, sData, oMap, bForced)
    {
        if (oMap == undefined)
        {
            return;
        } // end if
        var _loc10 = new Array();
        var _loc11 = sData.length;
        var _loc13 = 0;
        var _loc14 = 0;
        
        while (_loc14 = _loc14 + 10, _loc14 < _loc11)
        {
            var _loc12 = ank.battlefield.utils.Compressor.uncompressCell(sData.substring(_loc14, _loc14 + 10), bForced, 0);
            _loc12.num = _loc13;
            _loc10.push(_loc12);
            ++_loc13;
        } // end while
        oMap.id = Number(mapID);
        oMap.name = name;
        oMap.width = Number(width);
        oMap.height = Number(height);
        oMap.backgroundNum = backgroundNum;
        oMap.data = _loc10;
    };
    (_global.ank.battlefield.utils.Compressor = function ()
    {
        super();
    }).uncompressCell = function (sData, bForced, nPermanentLevel)
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
        var _loc5 = new ank.battlefield.datacenter.Cell();
        var _loc6 = sData.split("");
        var _loc7 = _loc6.length - 1;
        var _loc8 = new Array();
        while (_loc7 >= 0)
        {
            _loc8[_loc7] = ank.utils.Compressor._self._hashCodes[_loc6[_loc7]];
            --_loc7;
        } // end while
        _loc5.active = (_loc8[0] & 32) >> 5 ? (true) : (false);
        if (_loc5.active || bForced)
        {
            _loc5.nPermanentLevel = nPermanentLevel;
            _loc5.lineOfSight = _loc8[0] & 1 ? (true) : (false);
            _loc5.layerGroundRot = (_loc8[1] & 48) >> 4;
            _loc5.groundLevel = _loc8[1] & 15;
            _loc5.movement = (_loc8[2] & 56) >> 3;
            _loc5.layerGroundNum = ((_loc8[0] & 24) << 6) + ((_loc8[2] & 7) << 6) + _loc8[3];
            _loc5.groundSlope = (_loc8[4] & 60) >> 2;
            _loc5.layerGroundFlip = (_loc8[4] & 2) >> 1 ? (true) : (false);
            _loc5.layerObject1Num = ((_loc8[0] & 4) << 11) + ((_loc8[4] & 1) << 12) + (_loc8[5] << 6) + _loc8[6];
            _loc5.layerObject1Rot = (_loc8[7] & 48) >> 4;
            _loc5.layerObject1Flip = (_loc8[7] & 8) >> 3 ? (true) : (false);
            _loc5.layerObject2Flip = (_loc8[7] & 4) >> 2 ? (true) : (false);
            _loc5.layerObject2Interactive = (_loc8[7] & 2) >> 1 ? (true) : (false);
            _loc5.layerObject2Num = ((_loc8[0] & 2) << 12) + ((_loc8[7] & 1) << 12) + (_loc8[8] << 6) + _loc8[9];
            _loc5.layerObjectExternal = "";
            _loc5.layerObjectExternalInteractive = false;
        } // end if
        return (_loc5);
    };
    (_global.ank.battlefield.utils.Compressor = function ()
    {
        super();
    }).compressMap = function (oMap)
    {
        if (oMap == undefined)
        {
            return;
        } // end if
        var _loc3 = new Array();
        var _loc4 = oMap.data;
        var _loc5 = _loc4.length;
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc5)
        {
            _loc3.push(ank.battlefield.utils.Compressor.compressCell(_loc4[_loc6]));
        } // end while
        return (_loc3.join(""));
    };
    (_global.ank.battlefield.utils.Compressor = function ()
    {
        super();
    }).compressCell = function (oCell)
    {
        var _loc4 = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        _loc4[0] = (oCell.active ? (1) : (0)) << 5;
        _loc4[0] = _loc4[0] | (oCell.lineOfSight ? (1) : (0));
        _loc4[0] = _loc4[0] | (oCell.layerGroundNum & 1536) >> 6;
        _loc4[0] = _loc4[0] | (oCell.layerObject1Num & 8192) >> 11;
        _loc4[0] = _loc4[0] | (oCell.layerObject2Num & 8192) >> 12;
        _loc4[1] = (oCell.layerGroundRot & 3) << 4;
        _loc4[1] = _loc4[1] | oCell.groundLevel & 15;
        _loc4[2] = (oCell.movement & 7) << 3;
        _loc4[2] = _loc4[2] | oCell.layerGroundNum >> 6 & 7;
        _loc4[3] = oCell.layerGroundNum & 63;
        _loc4[4] = (oCell.groundSlope & 15) << 2;
        _loc4[4] = _loc4[4] | (oCell.layerGroundFlip ? (1) : (0)) << 1;
        _loc4[4] = _loc4[4] | oCell.layerObject1Num >> 12 & 1;
        _loc4[5] = oCell.layerObject1Num >> 6 & 63;
        _loc4[6] = oCell.layerObject1Num & 63;
        _loc4[7] = (oCell.layerObject1Rot & 3) << 4;
        _loc4[7] = _loc4[7] | (oCell.layerObject1Flip ? (1) : (0)) << 3;
        _loc4[7] = _loc4[7] | (oCell.layerObject2Flip ? (1) : (0)) << 2;
        _loc4[7] = _loc4[7] | (oCell.layerObject2Interactive ? (1) : (0)) << 1;
        _loc4[7] = _loc4[7] | oCell.layerObject2Num >> 12 & 1;
        _loc4[8] = oCell.layerObject2Num >> 6 & 63;
        _loc4[9] = oCell.layerObject2Num & 63;
        for (var _loc5 = _loc4.length - 1; _loc5 >= 0; --_loc5)
        {
            _loc4[_loc5] = ank.utils.Compressor.encode64(_loc4[_loc5]);
        } // end of for
        var _loc3 = _loc4.join("");
        return (_loc3);
    };
    (_global.ank.battlefield.utils.Compressor = function ()
    {
        super();
    }).compressPath = function (aFullPathData, bWithFirst)
    {
        var _loc4 = new String();
        var _loc5 = ank.battlefield.utils.Compressor.makeLightPath(aFullPathData, bWithFirst);
        var _loc11 = _loc5.length;
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc11)
        {
            var _loc7 = _loc5[_loc6];
            var _loc8 = _loc7.dir & 7;
            var _loc9 = (_loc7.num & 4032) >> 6;
            var _loc10 = _loc7.num & 63;
            _loc4 = _loc4 + ank.utils.Compressor.encode64(_loc8);
            _loc4 = _loc4 + ank.utils.Compressor.encode64(_loc9);
            _loc4 = _loc4 + ank.utils.Compressor.encode64(_loc10);
        } // end while
        return (_loc4);
    };
    (_global.ank.battlefield.utils.Compressor = function ()
    {
        super();
    }).makeLightPath = function (aFullPath, bWithFirst)
    {
        if (aFullPath == undefined)
        {
            ank.utils.Logger.err("Le chemin est vide");
            return (new Array());
        } // end if
        var _loc4 = new Array();
        if (bWithFirst)
        {
            _loc4.push(aFullPath[0]);
        } // end if
        for (var _loc6 = aFullPath.length - 1; _loc6 >= 0; --_loc6)
        {
            if (aFullPath[_loc6].dir != )
            {
                _loc4.splice(0, 0, aFullPath[_loc6]);
                var _loc5 = aFullPath[_loc6].dir;
            } // end if
        } // end of for
        return (_loc4);
    };
    (_global.ank.battlefield.utils.Compressor = function ()
    {
        super();
    }).extractFullPath = function (mapHandler, compressedData)
    {
        var _loc4 = new Array();
        var _loc5 = compressedData.split("");
        var _loc7 = compressedData.length;
        var _loc8 = mapHandler.getCellCount();
        var _loc6 = 0;
        
        while (_loc6 = _loc6 + 3, _loc6 < _loc7)
        {
            _loc5[_loc6] = ank.utils.Compressor.decode64(_loc5[_loc6]);
            _loc5[_loc6 + 1] = ank.utils.Compressor.decode64(_loc5[_loc6 + 1]);
            _loc5[_loc6 + 2] = ank.utils.Compressor.decode64(_loc5[_loc6 + 2]);
            var _loc9 = (_loc5[_loc6 + 1] & 15) << 6 | _loc5[_loc6 + 2];
            if (_loc9 < 0)
            {
                ank.utils.Logger.err("Case pas sur carte");
                return (null);
            } // end if
            if (_loc9 > _loc8)
            {
                ank.utils.Logger.err("Case pas sur carte");
                return (null);
            } // end if
            _loc4.push({num: _loc9, dir: _loc5[_loc6]});
        } // end while
        return (ank.battlefield.utils.Compressor.makeFullPath(mapHandler, _loc4));
    };
    (_global.ank.battlefield.utils.Compressor = function ()
    {
        super();
    }).makeFullPath = function (mapHandler, aLightPath)
    {
        var _loc4 = new Array();
        var _loc6 = 0;
        var _loc7 = mapHandler.getWidth();
        var _loc8 = [1, _loc7, _loc7 * 2 - 1, _loc7 - 1, -1, -_loc7, -_loc7 * 2 + 1, -(_loc7 - 1)];
        var _loc5 = aLightPath[0].num;
        _loc4[_loc6] = _loc5;
        var _loc9 = 1;
        
        while (++_loc9, _loc9 < aLightPath.length)
        {
            var _loc10 = aLightPath[_loc9].num;
            var _loc11 = aLightPath[_loc9].dir;
            var _loc12 = 2 * _loc7 + 1;
            while (_loc4[_loc6] != _loc10)
            {
                _loc5 = _loc5 + _loc8[_loc11];
                _loc4[++_loc6] = _loc5;
                if (--_loc12 < 0)
                {
                    ank.utils.Logger.err("Chemin impossible");
                    return (null);
                } // end if
            } // end while
            _loc5 = _loc10;
        } // end while
        return (_loc4);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
