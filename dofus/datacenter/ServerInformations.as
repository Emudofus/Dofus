// Action script...

// [Initial MovieClip Action of sprite 20502]
#initclip 23
if (!dofus.datacenter.ServerInformations)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.datacenter)
    {
        _global.dofus.datacenter = new Object();
    } // end if
    var _loc1 = (_global.dofus.datacenter.ServerInformations = function ()
    {
        super();
        this.initialize();
    }).prototype;
    _loc1.__get__problems = function ()
    {
        return (this._pProblems);
    };
    _loc1.__get__isOnFocus = function ()
    {
        return (this._bOnFocus);
    };
    _loc1.load = function ()
    {
        var _loc2 = this.api.lang.getConfigText("PROBLEMS_LINK");
        var _loc3 = new ank.utils.XMLLoader();
        _loc3.addEventListener("onXMLLoadComplete", this);
        _loc3.addEventListener("onXMLLoadError", this);
        _loc3.loadXML(_loc2);
        this.dispatchEvent({type: "onLoadStarted"});
    };
    _loc1.initialize = function ()
    {
        this.api = _global.API;
        mx.events.EventDispatcher.initialize(this);
    };
    _loc1.parseXml = function (xml)
    {
        this._pProblems = new Array();
        var _loc3 = xml.firstChild;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.childNodes.length)
        {
            var _loc5 = _loc3.childNodes[_loc4];
            var _loc6 = Number(_loc5.attributes.id);
            var _loc7 = Number(_loc5.attributes.date);
            var _loc8 = Number(_loc5.attributes.type);
            var _loc9 = Number(_loc5.attributes.state);
            var _loc10 = _loc5.attributes.visible == "true";
            this._bOnFocus = this._bOnFocus || _loc10;
            var _loc11 = _loc5.childNodes[0];
            var _loc12 = new Array();
            if (_loc11.attributes.cnx == "true")
            {
                _loc12.push(this.api.lang.getText("CONNECTION_SERVER"));
            } // end if
            if (_loc11.attributes.all == "true")
            {
                _loc12.push(this.api.lang.getText("EVERY_SERVERS"));
            }
            else
            {
                var _loc13 = 0;
                
                while (++_loc13, _loc13 < _loc11.childNodes.length)
                {
                    _loc12.push(_loc11.childNodes[_loc13].attributes.name);
                } // end while
            } // end else if
            var _loc14 = _loc5.childNodes[1];
            var _loc15 = new Array();
            var _loc16 = 0;
            
            while (++_loc16, _loc16 < _loc14.childNodes.length)
            {
                var _loc17 = _loc14.childNodes[_loc16];
                var _loc18 = Number(_loc17.attributes.timestamp);
                var _loc19 = Number(_loc17.attributes.id);
                var _loc20 = _loc17.attributes.translated == "true";
                var _loc21 = _loc17.firstChild.nodeValue;
                var _loc22 = new dofus.datacenter.ServerProblemEvent(_loc18, _loc19, _loc20, _loc21);
                _loc15.push(_loc22);
            } // end while
            var _loc23 = new dofus.datacenter.ServerProblem(_loc6, _loc7, _loc8, _loc9, _loc12, _loc15);
            this._pProblems.push(_loc23);
        } // end while
        this.dispatchEvent({type: "onData"});
    };
    _loc1.onXMLLoadComplete = function (oEvent)
    {
        var _loc3 = oEvent.value;
        this.parseXml(_loc3);
    };
    _loc1.onXMLLoadError = function ()
    {
        this.dispatchEvent({type: "onLoadError"});
    };
    _loc1.addProperty("isOnFocus", _loc1.__get__isOnFocus, function ()
    {
    });
    _loc1.addProperty("problems", _loc1.__get__problems, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
