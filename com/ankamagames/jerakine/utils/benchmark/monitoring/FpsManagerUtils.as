package com.ankamagames.jerakine.utils.benchmark.monitoring
{
    import flash.utils.Dictionary;
    import flash.utils.getTimer;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.ui.Graph;
    import __AS3__.vec.Vector;
    import flash.system.Capabilities;

    public class FpsManagerUtils 
    {


        public static function countKeys(myDictionary:Dictionary):int
        {
            var key:*;
            var n:int;
            for (key in myDictionary)
            {
                n++;
            };
            return (n);
        }

        public static function calculateMB(value:uint):Number
        {
            var newValue:Number = Math.round((((value / 0x0400) / 0x0400) * 100));
            return ((newValue / 100));
        }

        public static function getTimeFromNow(value:int):String
        {
            var mls:int = (getTimer() - value);
            var sec:int = (mls / 1000);
            var min:int = (sec / 60);
            sec = (sec - (min * 60));
            return ((((((min > 0)) ? (min.toString() + " min ") : "") + sec.toString()) + " sec"));
        }

        public static function isSpecialGraph(pIndice:String):Boolean
        {
            var g:Object;
            for each (g in FpsManagerConst.SPECIAL_GRAPH)
            {
                if (g.name == pIndice)
                {
                    return (true);
                };
            };
            return (false);
        }

        public static function numberOfSpecialGraphDisplayed(graphList:Dictionary):int
        {
            var g:Graph;
            var cpt:int;
            for each (g in graphList)
            {
                if (FpsManagerUtils.isSpecialGraph(g.indice))
                {
                    cpt++;
                };
            };
            return (cpt);
        }

        public static function getVectorMaxValue(vector:Vector.<Number>):Number
        {
            var v:Number;
            var value:Number = 0;
            for each (v in vector)
            {
                if (v > value)
                {
                    value = v;
                };
            };
            return (value);
        }

        public static function getVersion():Number
        {
            var _fullInfo:String = Capabilities.version;
            var _osSplitArr:Array = _fullInfo.split(" ");
            var _versionSplitArr:Array = _osSplitArr[1].split(",");
            var _versionInfo:Number = _versionSplitArr[0];
            return (_versionInfo);
        }

        public static function getBrightRandomColor():uint
        {
            var color:uint = getRandomColor();
            while (color < 0x7A1200)
            {
                color = getRandomColor();
            };
            return (color);
        }

        public static function getRandomColor():uint
        {
            return ((Math.random() * 0xFFFFFF));
        }

        public static function addAlphaToColor(rgb:uint, alpha:uint):uint
        {
            return (((alpha << 24) + rgb));
        }


    }
}//package com.ankamagames.jerakine.utils.benchmark.monitoring

