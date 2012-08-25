// Action script...

// [Initial MovieClip Action of sprite 20910]
#initclip 175
if (!ank.battlefield.InteractionHandler)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.battlefield)
    {
        _global.ank.battlefield = new Object();
    } // end if
    var _loc1 = (_global.ank.battlefield.InteractionHandler = function (c, d)
    {
        this.initialize(c, d);
    }).prototype;
    _loc1.initialize = function (c, d)
    {
        this._mcContainer = c;
        this._oDatacenter = d;
        this._extraProto = new Object();
        this.setEnabled(ank.battlefield.Constants.INTERACTION_NONE);
        this._bIs8 = Number(System.capabilities.version.substr(0, 1)) >= 8;
    };
    _loc1.setEnabled = function (nState)
    {
        switch (nState)
        {
            case ank.battlefield.Constants.INTERACTION_NONE:
            {
                this.setEnabledOffAllExtraProto();
                this.setEnabledProtoAll(ank.battlefield.mc.Cell.prototype, false);
                this.setEnabledProtoAll(ank.battlefield.mc.InteractiveObject.prototype, false);
                this.setEnabledProtoAll(ank.battlefield.mc.Sprite.prototype, false);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_CELL_NONE:
            {
                this.setEnabledOffAllExtraProto();
                this.setEnabledProtoAll(ank.battlefield.mc.Cell.prototype, false);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_CELL_RELEASE:
            {
                this.setEnabledProtoRelease(ank.battlefield.mc.Cell.prototype, true);
                this.setEnabledProtoOutOver(ank.battlefield.mc.Cell.prototype, false);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_CELL_OVER_OUT:
            {
                this.setEnabledProtoRelease(ank.battlefield.mc.Cell.prototype, false);
                this.setEnabledProtoOutOver(ank.battlefield.mc.Cell.prototype, true);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT:
            {
                this.setEnabledProtoAll(ank.battlefield.mc.Cell.prototype, true);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_OBJECT_NONE:
            {
                this.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype, false);
                this.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype, false);
                if (this._bIs8)
                {
                    this.setEnabledObject2Release(false);
                    this.setEnabledObject2OutOver(false);
                } // end if
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE:
            {
                this.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype, true);
                this.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype, false);
                if (this._bIs8)
                {
                    this.setEnabledObject2Release(true);
                    this.setEnabledObject2OutOver(false);
                } // end if
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_OBJECT_OVER_OUT:
            {
                this.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype, false);
                this.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype, true);
                if (this._bIs8)
                {
                    this.setEnabledObject2Release(false);
                    this.setEnabledObject2OutOver(true);
                } // end if
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT:
            {
                this.setEnabledProtoAll(ank.battlefield.mc.InteractiveObject.prototype, true);
                if (this._bIs8)
                {
                    this.setEnabledObject2All(true);
                } // end if
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_SPRITE_NONE:
            {
                this.setEnabledProtoRelease(ank.battlefield.mc.Sprite.prototype, false);
                this.setEnabledProtoOutOver(ank.battlefield.mc.Sprite.prototype, false);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_SPRITE_RELEASE:
            {
                this.setEnabledProtoRelease(ank.battlefield.mc.Sprite.prototype, true);
                this.setEnabledProtoOutOver(ank.battlefield.mc.Sprite.prototype, false);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_SPRITE_OVER_OUT:
            {
                this.setEnabledProtoRelease(ank.battlefield.mc.Sprite.prototype, false);
                this.setEnabledProtoOutOver(ank.battlefield.mc.Sprite.prototype, true);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_SPRITE_RELEASE_OVER_OUT:
            {
                this.setEnabledProtoAll(ank.battlefield.mc.Sprite.prototype, true);
                break;
            } 
        } // End of switch
    };
    _loc1.setEnabledCell = function (nCellNum, nState)
    {
        var _loc4 = this._mcContainer["cell" + nCellNum];
        if (_loc4 == undefined)
        {
            ank.utils.Logger.err("[setEnabledCell] Cell inexistante");
            return;
        } // end if
        this._extraProto[_loc4._name] = _loc4;
        switch (nState)
        {
            case ank.battlefield.Constants.INTERACTION_NONE:
            {
                this.setEnabledProtoAll(_loc4, false);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_CELL_RELEASE:
            {
                this.setEnabledProtoRelease(_loc4, true);
                this.setEnabledProtoOutOver(_loc4, false);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_CELL_OVER_OUT:
            {
                this.setEnabledProtoRelease(_loc4, false);
                this.setEnabledProtoOutOver(_loc4, true);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT:
            {
                this.setEnabledProtoAll(_loc4, true);
                break;
            } 
        } // End of switch
    };
    _loc1.setEnabledOffAllExtraProto = function (Void)
    {
        for (var p in this._extraProto)
        {
            var _loc3 = this._extraProto[p];
            this.setEnabledProtoAll(_loc3, false);
        } // end of for...in
        this._extraProto = new Array();
    };
    _loc1.setEnabledProtoAll = function (proto, bool)
    {
        if (bool)
        {
            proto.onRelease = proto._release;
            proto.onRollOver = proto._rollOver;
            proto.onRollOut = proto.onReleaseOutside = proto._rollOut;
        }
        else
        {
            delete proto.onRelease;
            delete proto.onRollOver;
            delete proto.onRollOut;
            delete proto.onReleaseOutside;
        } // end else if
    };
    _loc1.setEnabledProtoRelease = function (proto, bool)
    {
        if (bool)
        {
            proto.onRelease = proto._release;
        }
        else
        {
            delete proto.onRelease;
        } // end else if
    };
    _loc1.setEnabledProtoOutOver = function (proto, bool)
    {
        if (bool)
        {
            proto.onRollOver = proto._rollOver;
            proto.onRollOut = proto._rollOut;
            proto.onRollOut = proto.onReleaseOutside = proto._rollOut;
        }
        else
        {
            delete proto.onRollOver;
            delete proto.onRollOut;
            delete proto.onReleaseOutside;
        } // end else if
    };
    _loc1.setEnabledObject2All = function (bool)
    {
        var _loc3 = this._oDatacenter.Map.data;
        for (var k in _loc3)
        {
            var _loc4 = _loc3[k].mcObject2;
            if (!_loc3[k].layerObject2Interactive)
            {
                continue;
            } // end if
            if (_loc4 == undefined)
            {
                continue;
            } // end if
            if (bool)
            {
                _loc4.onRelease = _loc4._release;
                _loc4.onRollOver = _loc4._rollOver;
                _loc4.onRollOut = _loc4.onReleaseOutside = _loc4._rollOut;
                continue;
            } // end if
            delete _loc4.onRelease;
            delete _loc4.onRollOver;
            delete _loc4.onRollOut;
            delete _loc4.onReleaseOutside;
        } // end of for...in
    };
    _loc1.setEnabledObject2Release = function (bool)
    {
        var _loc3 = this._oDatacenter.Map.data;
        for (var k in _loc3)
        {
            var _loc4 = _loc3[k].mcObject2;
            if (!_loc3[k].layerObject2Interactive)
            {
                continue;
            } // end if
            if (_loc4 == undefined)
            {
                continue;
            } // end if
            if (bool)
            {
                _loc4.onRelease = _loc4._release;
                continue;
            } // end if
            delete _loc4.onRelease;
        } // end of for...in
    };
    _loc1.setEnabledObject2OutOver = function (bool)
    {
        var _loc3 = this._oDatacenter.Map.data;
        for (var k in _loc3)
        {
            var _loc4 = _loc3[k].mcObject2;
            if (!_loc3[k].layerObject2Interactive)
            {
                continue;
            } // end if
            if (_loc4 == undefined)
            {
                continue;
            } // end if
            if (bool)
            {
                _loc4.onRollOver = _loc4._rollOver;
                _loc4.onRollOut = _loc4._rollOut;
                _loc4.onRollOut = _loc4.onReleaseOutside = _loc4._rollOut;
                continue;
            } // end if
            delete _loc4.onRollOver;
            delete _loc4.onRollOut;
            delete _loc4.onReleaseOutside;
        } // end of for...in
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
