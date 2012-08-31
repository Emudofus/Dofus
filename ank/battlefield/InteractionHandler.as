// Action script...

// [Initial MovieClip Action of sprite 855]
#initclip 67
class ank.battlefield.InteractionHandler
{
    var _mcContainer, _extraProto;
    function InteractionHandler(c)
    {
        this.initialize(c);
    } // End of the function
    function initialize(c)
    {
        _mcContainer = c;
        _extraProto = new Object();
        this.setEnabled(ank.battlefield.Constants.INTERACTION_NONE);
    } // End of the function
    function setEnabled(nState)
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
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE:
            {
                this.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype, true);
                this.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype, false);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_OBJECT_OVER_OUT:
            {
                this.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype, false);
                this.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype, true);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT:
            {
                this.setEnabledProtoAll(ank.battlefield.mc.InteractiveObject.prototype, true);
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
    } // End of the function
    function setEnabledCell(nCellNum, nState)
    {
        var _loc2 = _mcContainer["cell" + nCellNum];
        if (_loc2 == undefined)
        {
            ank.utils.Logger.err("[setEnabledCell] Cell inexistante");
            return;
        } // end if
        _extraProto[_loc2._name] = _loc2;
        switch (nState)
        {
            case ank.battlefield.Constants.INTERACTION_NONE:
            {
                this.setEnabledProtoAll(_loc2, false);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_CELL_RELEASE:
            {
                this.setEnabledProtoRelease(_loc2, true);
                this.setEnabledProtoOutOver(_loc2, false);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_CELL_OVER_OUT:
            {
                this.setEnabledProtoRelease(_loc2, false);
                this.setEnabledProtoOutOver(_loc2, true);
                break;
            } 
            case ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT:
            {
                this.setEnabledProtoAll(_loc2, true);
                break;
            } 
        } // End of switch
    } // End of the function
    function setEnabledOffAllExtraProto(Void)
    {
        for (var _loc3 in _extraProto)
        {
            var _loc2 = _extraProto[_loc3];
            this.setEnabledProtoAll(_loc2, false);
        } // end of for...in
        _extraProto = new Array();
    } // End of the function
    function setEnabledProtoAll(proto, bool)
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
    } // End of the function
    function setEnabledProtoRelease(proto, bool)
    {
        if (bool)
        {
            proto.onRelease = proto._release;
        }
        else
        {
            delete proto.onRelease;
        } // end else if
    } // End of the function
    function setEnabledProtoOutOver(proto, bool)
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
    } // End of the function
} // End of Class
#endinitclip
