// Action script...

// [Initial MovieClip Action of sprite 1032]
#initclip 253
class dofus.graphics.gapi.controls.ClassCustomize extends ank.gapi.core.UIAdvancedComponent
{
    var _nClassID, addToQueue, __get__classID, _nSex, __get__sex, __get__colors, _itCharacterName, __get__name, _visible, _oColors, _oBakColors, _ldrSprite, api, _cpColorPicker, _btnNextAnim, _btnPreviousAnim, _btnReset1, _btnReset2, _btnReset3, _btnColor1, _btnColor2, _btnColor3, _lblCharacterColors, _lblCharacterName, _nSelectedColorIndex, dispatchEvent, __set__classID, __set__colors, __set__name, __set__sex;
    function ClassCustomize()
    {
        super();
    } // End of the function
    function set classID(nClassID)
    {
        _nClassID = nClassID;
        this.addToQueue({object: this, method: layoutContent});
        //return (this.classID());
        null;
    } // End of the function
    function set sex(nSex)
    {
        _nSex = nSex;
        this.addToQueue({object: this, method: layoutContent});
        //return (this.sex());
        null;
    } // End of the function
    function set colors(aColors)
    {
        this.addToQueue({object: this, method: applyColor, params: [aColors[0], 1]});
        this.addToQueue({object: this, method: applyColor, params: [aColors[1], 2]});
        this.addToQueue({object: this, method: applyColor, params: [aColors[2], 3]});
        this.addToQueue({object: this, method: updateSprite});
        //return (this.colors());
        null;
    } // End of the function
    function set name(sName)
    {
        this.addToQueue({object: this, method: function ()
        {
            _itCharacterName.text = sName;
        }});
        //return (this.name());
        null;
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.ClassCustomize.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        _visible = false;
        _oColors = {color1: -1, color2: -1, color3: -1};
        _oBakColors = {color1: -1, color2: -1, color3: -1};
        _itCharacterName.__set__restrict("a-zA-Z\\-");
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initTexts});
        api.colors.addSprite(_ldrSprite, _oColors);
        this.addToQueue({object: this, method: setColorIndex, params: [1]});
        this.addToQueue({object: this, method: function ()
        {
            _itCharacterName.setFocus();
        }});
        this.addToQueue({object: this, method: function ()
        {
            _visible = true;
        }});
    } // End of the function
    function addListeners()
    {
        _cpColorPicker.addEventListener("change", this);
        _ldrSprite.addEventListener("initialization", this);
        _btnNextAnim.addEventListener("click", this);
        _btnPreviousAnim.addEventListener("click", this);
        _btnReset1.addEventListener("click", this);
        _btnReset2.addEventListener("click", this);
        _btnReset3.addEventListener("click", this);
        _btnColor1.addEventListener("click", this);
        _btnColor2.addEventListener("click", this);
        _btnColor3.addEventListener("click", this);
        _btnColor1.addEventListener("over", this);
        _btnColor2.addEventListener("over", this);
        _btnColor3.addEventListener("over", this);
        _btnColor1.addEventListener("out", this);
        _btnColor2.addEventListener("out", this);
        _btnColor3.addEventListener("out", this);
        _itCharacterName.addEventListener("change", this);
    } // End of the function
    function initTexts()
    {
        _lblCharacterColors.__set__text(api.lang.getText("SPRITE_COLORS"));
        _lblCharacterName.__set__text(api.lang.getText("CREATE_CHARACTER_NAME"));
    } // End of the function
    function layoutContent()
    {
        if (_nClassID == undefined || _nSex == undefined)
        {
            return;
        } // end if
        _ldrSprite.__set__contentPath(dofus.Constants.CLIPS_PERSOS_PATH + _nClassID + _nSex + ".swf");
    } // End of the function
    function applyColor(nColor, nIndex)
    {
        if (nIndex == undefined)
        {
            nIndex = _nSelectedColorIndex;
        } // end if
        var _loc4 = {ColoredButton: {bgcolor: nColor == -1 ? (16711680) : (nColor), highlightcolor: nColor == -1 ? (16777215) : (nColor), bgdowncolor: nColor == -1 ? (16711680) : (nColor), highlightdowncolor: nColor == -1 ? (16777215) : (nColor)}};
        ank.gapi.styles.StylesManager.loadStylePackage(_loc4);
        this["_btnColor" + nIndex].styleName = "ColoredButton";
        _oColors["color" + nIndex] = nColor;
        _oBakColors["color" + nIndex] = nColor;
        this.updateSprite();
    } // End of the function
    function setColorIndex(nIndex)
    {
        var _loc2 = this["_btnColor" + _nSelectedColorIndex];
        var _loc3 = this["_btnColor" + nIndex];
        _loc2.__set__selected(false);
        _loc3.__set__selected(true);
        _nSelectedColorIndex = nIndex;
    } // End of the function
    function showColorPosition(nIndex)
    {
        var bWhite = true;
        function onEnterFrame()
        {
            _oColors["color" + nIndex] = bWhite ? (16733525) : (16746632);
            this.updateSprite();
            bWhite = !bWhite;
        } // End of the function
    } // End of the function
    function hideColorPosition(nIndex)
    {
        delete this.onEnterFrame;
        _oColors.color1 = _oBakColors.color1;
        _oColors.color2 = _oBakColors.color2;
        _oColors.color3 = _oBakColors.color3;
        this.updateSprite();
    } // End of the function
    function updateSprite()
    {
        var _loc2 = _ldrSprite.__get__content();
        _loc2.mcAnim.removeMovieClip();
        _loc2.attachMovie(dofus.graphics.gapi.controls.ClassCustomize.SPRITE_ANIMS[_nSpriteAnimIndex], "mcAnim", 10);
        _loc2._xscale = _loc2._yscale = 120;
    } // End of the function
    function change(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_itCharacterName":
            {
                this.dispatchEvent({type: "nameChange", value: _itCharacterName.__get__text()});
                break;
            } 
            case "_cpColorPicker":
            {
                this.applyColor(oEvent.value);
                this.dispatchEvent({type: "colorsChange", value: _oColors});
                break;
            } 
        } // End of switch
    } // End of the function
    function initialization(oEvent)
    {
        this.updateSprite();
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnNextAnim":
            {
                ++_nSpriteAnimIndex;
                if (_nSpriteAnimIndex >= dofus.graphics.gapi.controls.ClassCustomize.SPRITE_ANIMS.length)
                {
                    _nSpriteAnimIndex = 0;
                } // end if
                this.updateSprite();
                break;
            } 
            case "_btnPreviousAnim":
            {
                --_nSpriteAnimIndex;
                if (_nSpriteAnimIndex < 0)
                {
                    _nSpriteAnimIndex = dofus.graphics.gapi.controls.ClassCustomize.SPRITE_ANIMS.length - 1;
                } // end if
                this.updateSprite();
                break;
            } 
            case "_btnColor1":
            case "_btnColor2":
            case "_btnColor3":
            {
                var _loc4 = Number(oEvent.target._name.substr(9));
                var _loc2 = _oBakColors["color" + _loc4];
                if (_loc2 != -1)
                {
                    _cpColorPicker.setColor(_loc2);
                } // end if
                this.setColorIndex(_loc4);
                break;
            } 
            case "_btnReset1":
            case "_btnReset2":
            case "_btnReset3":
            {
                _loc4 = Number(oEvent.target._name.substr(9));
                this.applyColor(-1, _loc4);
                break;
            } 
        } // End of switch
    } // End of the function
    function over(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnColor1":
            case "_btnColor2":
            case "_btnColor3":
            {
                var _loc2 = Number(oEvent.target._name.substr(9));
                this.showColorPosition(_loc2);
                break;
            } 
        } // End of switch
    } // End of the function
    function out(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnColor1":
            case "_btnColor2":
            case "_btnColor3":
            {
                var _loc3 = Number(oEvent.target._name.substr(9));
                this.hideColorPosition();
                break;
            } 
        } // End of switch
    } // End of the function
    static var CLASS_NAME = "ClassCustomize";
    static var SPRITE_ANIMS = ["StaticF", "StaticR", "StaticL", "WalkF", "RunF", "Anim2R", "Anim2L"];
    var _nSpriteAnimIndex = 0;
} // End of Class
#endinitclip
