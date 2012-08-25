// Action script...

// [Initial MovieClip Action of sprite 20665]
#initclip 186
if (!dofus.graphics.gapi.controls.ColorSelector)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.controls)
    {
        _global.dofus.graphics.gapi.controls = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.controls.ColorSelector = function ()
    {
        super();
    }).prototype;
    _loc1.__set__colors = function (aColors)
    {
        this.addToQueue({object: this, method: this.applyColor, params: [aColors[0], 1]});
        this.addToQueue({object: this, method: this.applyColor, params: [aColors[1], 2]});
        this.addToQueue({object: this, method: this.applyColor, params: [aColors[2], 3]});
        //return (this.colors());
    };
    _loc1.__set__breed = function (nBreed)
    {
        this._nBreed = nBreed;
        //return (this.breed());
    };
    _loc1.__set__sex = function (nSex)
    {
        this._nSex = nSex;
        //return (this.sex());
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.controls.ColorSelector.CLASS_NAME);
    };
    _loc1.createChildren = function ()
    {
        this.addToQueue({object: this, method: this.initData});
        this.addToQueue({object: this, method: this.addListeners});
    };
    _loc1.initData = function ()
    {
        this._oColors = {color1: -1, color2: -1, color3: -1};
        this._oBakColors = {color1: -1, color2: -1, color3: -1};
    };
    _loc1.addListeners = function ()
    {
        this._btnColor1.addEventListener("click", this);
        this._btnColor2.addEventListener("click", this);
        this._btnColor3.addEventListener("click", this);
        this._btnColor1.addEventListener("over", this);
        this._btnColor2.addEventListener("over", this);
        this._btnColor3.addEventListener("over", this);
        this._btnColor1.addEventListener("out", this);
        this._btnColor2.addEventListener("out", this);
        this._btnColor3.addEventListener("out", this);
        this._cpColorPicker.addEventListener("change", this);
        this._btnReset.addEventListener("click", this);
        this._btnReset.addEventListener("over", this);
        this._btnReset.addEventListener("out", this);
        var ref = this;
        this._mcRandomColor1.onPress = function ()
        {
            ref.click({target: this});
        };
        this._mcRandomColor2.onPress = function ()
        {
            ref.click({target: this});
        };
        this._mcRandomColor3.onPress = function ()
        {
            ref.click({target: this});
        };
        this._mcRandomAll.onPress = function ()
        {
            ref.click({target: this});
        };
        this._mcRandomColor1.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcRandomColor2.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcRandomColor3.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcRandomAll.onRollOver = function ()
        {
            ref.over({target: this});
        };
        this._mcRandomColor1.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcRandomColor2.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcRandomColor3.onRollOut = function ()
        {
            ref.out({target: this});
        };
        this._mcRandomAll.onRollOut = function ()
        {
            ref.out({target: this});
        };
    };
    _loc1.setColorIndex = function (nIndex)
    {
        var _loc3 = this["_btnColor" + this._nSelectedColorIndex];
        var _loc4 = this["_btnColor" + nIndex];
        _loc3.selected = false;
        _loc4.selected = true;
        this._nSelectedColorIndex = nIndex;
    };
    _loc1.applyColor = function (nColor, nIndex)
    {
        if (nIndex == undefined)
        {
            nIndex = this._nSelectedColorIndex;
        } // end if
        var _loc4 = {ColoredButton: {bgcolor: nColor == -1 ? (16711680) : (nColor), highlightcolor: nColor == -1 ? (16777215) : (nColor), bgdowncolor: nColor == -1 ? (16711680) : (nColor), highlightdowncolor: nColor == -1 ? (16777215) : (nColor)}};
        ank.gapi.styles.StylesManager.loadStylePackage(_loc4);
        this["_btnColor" + nIndex].styleName = "ColoredButton";
        this._oColors["color" + nIndex] = nColor;
        this._oBakColors["color" + nIndex] = nColor;
    };
    _loc1.selectColor = function (nIndex)
    {
        var _loc3 = this._oBakColors["color" + nIndex];
        if (_loc3 != -1)
        {
            this._cpColorPicker.setColor(_loc3);
        } // end if
        this.setColorIndex(nIndex);
    };
    (_global.dofus.graphics.gapi.controls.ColorSelector = function ()
    {
        super();
    }).d2h = function (d)
    {
        if (d > 255)
        {
            d = 255;
        } // end if
        return (dofus.graphics.gapi.controls.ColorSelector.HEX_CHARS[Math.floor(d / 16)] + dofus.graphics.gapi.controls.ColorSelector.HEX_CHARS[d % 16]);
    };
    _loc1.displayColorCode = function (nIndex)
    {
        this.selectColor(nIndex);
        var _loc3 = (this._oColors["color" + nIndex] & 16711680) >> 16;
        var _loc4 = (this._oColors["color" + nIndex] & 65280) >> 8;
        var _loc5 = this._oColors["color" + nIndex] & 255;
        var _loc6 = dofus.graphics.gapi.controls.ColorSelector.d2h(_loc3) + dofus.graphics.gapi.controls.ColorSelector.d2h(_loc4) + dofus.graphics.gapi.controls.ColorSelector.d2h(_loc5);
        if (this._oColors["color" + nIndex] == undefined || this._oColors["color" + nIndex] == -1)
        {
            _loc6 = "";
        } // end if
        var _loc7 = this.gapi.loadUIComponent("PopupHexa", "PopupHexa", {value: _loc6, params: {targetType: "colorCode", colorIndex: nIndex}});
        _loc7.addEventListener("validate", this);
    };
    _loc1.setColor = function (nIndex, nValue)
    {
        this.setColorIndex(nIndex);
        this.change({target: this._cpColorPicker, value: nValue});
        this.click({target: this["_btnColor" + nIndex]});
    };
    _loc1.hueVariation = function (nColor, nVariation, bNoBalance)
    {
        var _loc5 = this.rgb2hsl(nColor);
        if (_loc5.h < 5.000000E-001 && !bNoBalance)
        {
            nVariation = -nVariation;
        } // end if
        _loc5.h = _loc5.h + nVariation;
        if (_loc5.h > 1)
        {
            --_loc5.h;
        } // end if
        if (_loc5.h < 0)
        {
            ++_loc5.h;
        } // end if
        return (this.hsl2rgb(_loc5.h, _loc5.s, _loc5.l));
    };
    _loc1.lightVariation = function (nColor, nVariation)
    {
        var _loc4 = this.rgb2hsl(nColor);
        _loc4.l = _loc4.l + nVariation;
        if (_loc4.l > 1)
        {
            _loc4.l = 1;
        } // end if
        if (_loc4.l < 0)
        {
            _loc4.l = 0;
        } // end if
        return (this.hsl2rgb(_loc4.h, _loc4.s, _loc4.l));
    };
    _loc1.complementaryColor = function (nColor)
    {
        var _loc3 = this.rgb2hsl(nColor);
        var _loc4 = _loc3.h + 5.000000E-001;
        if (_loc4 > 1)
        {
            --_loc4;
        } // end if
        return (this.hsl2rgb(_loc4, _loc3.s, _loc3.l));
    };
    _loc1.hsl2rgb = function (h, s, l)
    {
        if (s == 0)
        {
            var _loc5 = l * 255;
            var _loc6 = l * 255;
            var _loc7 = l * 255;
        }
        else
        {
            if (l < 5.000000E-001)
            {
                var _loc8 = l * (1 + s);
            }
            else
            {
                _loc8 = l + s - s * l;
            } // end else if
            var _loc9 = 2 * l - _loc8;
            _loc5 = 255 * this.h2rgb(_loc9, _loc8, h + 1 / 3);
            _loc6 = 255 * this.h2rgb(_loc9, _loc8, h);
            _loc7 = 255 * this.h2rgb(_loc9, _loc8, h - 1 / 3);
        } // end else if
        return (Number("0x" + dofus.graphics.gapi.controls.ColorSelector.d2h(Math.round(_loc5)) + dofus.graphics.gapi.controls.ColorSelector.d2h(Math.round(_loc6)) + dofus.graphics.gapi.controls.ColorSelector.d2h(Math.round(_loc7))));
    };
    _loc1.rgb2hsl = function (nColor)
    {
        var _loc3 = ((nColor & 16711680) >> 16) / 255;
        var _loc4 = ((nColor & 65280) >> 8) / 255;
        var _loc5 = (nColor & 255) / 255;
        var _loc6 = this.min(_loc3, _loc4, _loc5);
        var _loc7 = this.max(_loc3, _loc4, _loc5);
        var _loc8 = _loc7 - _loc6;
        var _loc9 = (_loc7 + _loc6) / 2;
        if (_loc8 == 0)
        {
            var _loc10 = 0;
            var _loc11 = 0;
        }
        else
        {
            if (_loc9 < 5.000000E-001)
            {
                _loc11 = _loc8 / (_loc7 + _loc6);
            }
            else
            {
                _loc11 = _loc8 / (2 - _loc7 - _loc6);
            } // end else if
            var _loc12 = ((_loc7 - _loc3) / 6 + _loc8 / 2) / _loc8;
            var _loc13 = ((_loc7 - _loc4) / 6 + _loc8 / 2) / _loc8;
            var _loc14 = ((_loc7 - _loc5) / 6 + _loc8 / 2) / _loc8;
            if (_loc3 == _loc7)
            {
                _loc10 = _loc14 - _loc13;
            }
            else if (_loc4 == _loc7)
            {
                _loc10 = 1 / 3 + _loc12 - _loc14;
            }
            else if (_loc5 == _loc7)
            {
                _loc10 = 2 / 3 + _loc13 - _loc12;
            } // end else if
            if (_loc10 < 0)
            {
                ++_loc10;
            } // end if
            if (_loc10 > 1)
            {
                --_loc10;
            } // end if
        } // end else if
        return ({h: _loc10, s: _loc11, l: _loc9});
    };
    _loc1.h2rgb = function (v1, v2, h)
    {
        if (h < 0)
        {
            ++h;
        } // end if
        if (h > 1)
        {
            --h;
        } // end if
        if (6 * h < 1)
        {
            return (v1 + (v2 - v1) * 6 * h);
        } // end if
        if (2 * h < 1)
        {
            return (v2);
        } // end if
        if (3 * h < 2)
        {
            return (v1 + (v2 - v1) * ((2 / 3 - h) * 6));
        } // end if
        return (v1);
    };
    _loc1.min = function ()
    {
        var _loc2 = Number.POSITIVE_INFINITY;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < arguments.length)
        {
            if (!_global.isNaN(Number(arguments[_loc3])) && _loc2 > Number(arguments[_loc3]))
            {
                _loc2 = Number(arguments[_loc3]);
            } // end if
        } // end while
        return (_loc2);
    };
    _loc1.max = function ()
    {
        var _loc2 = Number.NEGATIVE_INFINITY;
        var _loc3 = 0;
        
        while (++_loc3, _loc3 < arguments.length)
        {
            if (!_global.isNaN(Number(arguments[_loc3])) && _loc2 < Number(arguments[_loc3]))
            {
                _loc2 = Number(arguments[_loc3]);
            } // end if
        } // end while
        return (_loc2);
    };
    _loc1.isSkin = function (nIndex)
    {
        return (dofus.Constants.BREED_SKIN_INDEXES[this._nSex][this._nBreed - 1] == nIndex);
    };
    _loc1.randomSkin = function ()
    {
        return (this.lightVariation(dofus.Constants.BREED_SKIN_BASE_COLOR[this._nSex][this._nBreed - 1], Math.random() * 2.000000E-001 * (Math.random() > 5.000000E-001 ? (1) : (-1))));
    };
    _loc1.click = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnColor1:
            case this._btnColor2:
            case this._btnColor3:
            {
                var _loc3 = Number(oEvent.target._name.substr(9));
                if (Key.isDown(Key.SHIFT))
                {
                    this.displayColorCode(_loc3);
                }
                else if (Key.isDown(Key.CONTROL))
                {
                    this.applyColor(-1, _loc3);
                }
                else
                {
                    this.selectColor(_loc3);
                } // end else if
                break;
            } 
            case this._mcRandomColor1:
            case this._mcRandomColor2:
            case this._mcRandomColor3:
            {
                var _loc4 = Number(oEvent.target._name.substr(14));
                this.setColor(_loc4, Math.round(Math.random() * 16777215));
                break;
            } 
            case this._mcRandomAll:
            {
                var _loc5 = Math.floor(Math.random() * dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX);
                var _loc6 = Math.ceil(Math.random() * 16777215);
                this.setColor(_loc5, this.isSkin(_loc5) ? (this.randomSkin()) : (_loc6));
                ++_loc5;
                if (_loc5 > dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX)
                {
                    _loc5 = _loc5 - dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX;
                } // end if
                this.setColor(_loc5, this.isSkin(_loc5) ? (this.randomSkin()) : (this.complementaryColor(_loc6)));
                ++_loc5;
                if (_loc5 > dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX)
                {
                    _loc5 = _loc5 - dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX;
                } // end if
                this.setColor(_loc5, this.isSkin(_loc5) ? (this.randomSkin()) : (this.hueVariation(_loc6, Math.random())));
                break;
            } 
            case this._btnReset:
            {
                var _loc7 = 1;
                
                while (++_loc7, _loc7 <= dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX)
                {
                    this.applyColor(-1, _loc7);
                } // end while
                this.dispatchEvent({type: "change", value: this._oColors});
                break;
            } 
        } // End of switch
    };
    _loc1.over = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnColor1:
            case this._btnColor2:
            case this._btnColor3:
            {
                var _loc3 = Number(oEvent.target._name.substr(9));
                this.dispatchEvent({type: "over", index: _loc3});
                break;
            } 
            case this._btnReset:
            {
                this.gapi.showTooltip(this.api.lang.getText("REINIT_WORD"), oEvent.target, -20);
                break;
            } 
            case this._mcRandomColor1:
            case this._mcRandomColor2:
            case this._mcRandomColor3:
            {
                this.gapi.showTooltip(this.api.lang.getText("RANDOM_COLOR"), _root._xmouse, _root._ymouse - 20);
                break;
            } 
            case this._mcRandomAll:
            {
                this.gapi.showTooltip(this.api.lang.getText("RANDOM_ALL_COLORS"), _root._xmouse, _root._ymouse - 20);
                break;
            } 
        } // End of switch
    };
    _loc1.out = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._btnColor1:
            case this._btnColor2:
            case this._btnColor3:
            {
                var _loc3 = Number(oEvent.target._name.substr(9));
                this.dispatchEvent({type: "out", index: _loc3});
                break;
            } 
            default:
            {
                this.gapi.hideTooltip();
                break;
            } 
        } // End of switch
    };
    _loc1.change = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._cpColorPicker:
            {
                this.applyColor(oEvent.value);
                this.dispatchEvent({type: "change", value: this._oColors});
                break;
            } 
        } // End of switch
    };
    _loc1.validate = function (oEvent)
    {
        switch (oEvent.params.targetType)
        {
            case "colorCode":
            {
                if (_global.isNaN(oEvent.value) || (oEvent.value > 16777215 || oEvent.value == undefined))
                {
                    break;
                } // end if
                this.setColor(oEvent.params.colorIndex, oEvent.value);
                break;
            } 
        } // End of switch
    };
    _loc1.addProperty("breed", function ()
    {
    }, _loc1.__set__breed);
    _loc1.addProperty("colors", function ()
    {
    }, _loc1.__set__colors);
    _loc1.addProperty("sex", function ()
    {
    }, _loc1.__set__sex);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.controls.ColorSelector = function ()
    {
        super();
    }).CLASS_NAME = "ColorSelector";
    (_global.dofus.graphics.gapi.controls.ColorSelector = function ()
    {
        super();
    }).MAXIMUM_COLOR_INDEX = 3;
    _loc1._nSelectedColorIndex = 1;
    (_global.dofus.graphics.gapi.controls.ColorSelector = function ()
    {
        super();
    }).HEX_CHARS = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];
} // end if
#endinitclip
