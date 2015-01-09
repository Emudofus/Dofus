package com.ankamagames.berilia.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.berilia.types.listener.GenericListener;

    public class GenericEventsManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GenericEventsManager));

        protected var _aEvent:Array;

        public function GenericEventsManager()
        {
            this._aEvent = new Array();
            super();
        }

        public function initialize():void
        {
            this._aEvent = new Array();
        }

        public function registerEvent(ge:GenericListener):void
        {
            if (this._aEvent[ge.event] == null)
            {
                this._aEvent[ge.event] = new Array();
            };
            this._aEvent[ge.event].push(ge);
            (this._aEvent[ge.event] as Array).sortOn("sortIndex", (Array.NUMERIC | Array.DESCENDING));
        }

        public function removeEventListener(ge:GenericListener):void
        {
            var i:String;
            var j:int;
            var genericListener:GenericListener;
            for (i in this._aEvent)
            {
                if (!(this._aEvent[i]))
                {
                }
                else
                {
                    j = 0;
                    while (j < this._aEvent[i].length)
                    {
                        genericListener = this._aEvent[i][j];
                        if (!(genericListener))
                        {
                        }
                        else
                        {
                            if (genericListener == ge)
                            {
                                genericListener.destroy();
                                (this._aEvent[i] as Array).splice(j, 1);
                                j--;
                            };
                        };
                        j++;
                    };
                    if (!(this._aEvent[i].length))
                    {
                        this._aEvent[i] = null;
                        delete this._aEvent[i];
                    };
                };
            };
        }

        public function removeAllEventListeners(sListener:*):void
        {
            var i:String;
            var j:int;
            var genericListener:GenericListener;
            for (i in this._aEvent)
            {
                if (!(this._aEvent[i]))
                {
                }
                else
                {
                    j = 0;
                    while (j < this._aEvent[i].length)
                    {
                        genericListener = this._aEvent[i][j];
                        if (!(genericListener))
                        {
                        }
                        else
                        {
                            if (genericListener.listener == sListener)
                            {
                                genericListener.destroy();
                                (this._aEvent[i] as Array).splice(j, 1);
                                j--;
                            };
                        };
                        j++;
                    };
                    if (!(this._aEvent[i].length))
                    {
                        this._aEvent[i] = null;
                        delete this._aEvent[i];
                    };
                };
            };
        }


    }
}//package com.ankamagames.berilia.managers

