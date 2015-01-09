package com.ankamagames.jerakine.utils.misc
{
    public class CopyObject 
    {


        public static function copyObject(o:Object, exclude:Array=null, output:Object=null):Object
        {
            var p:String;
            if (!(output))
            {
                output = new Object();
            };
            var properties:Array = DescribeTypeCache.getVariables(o);
            for each (p in properties)
            {
                if (!((((exclude) && (!((exclude.indexOf(p) == -1))))) || ((p == "prototype"))))
                {
                    try
                    {
                        output[p] = o[p];
                    }
                    catch(e:SecurityError)
                    {
                        trace(("Error while copying field " + p));
                    };
                };
            };
            return (output);
        }


    }
}//package com.ankamagames.jerakine.utils.misc

