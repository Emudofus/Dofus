package com.ankamagames.tiphon.types
{
    import com.ankamagames.tiphon.engine.BoneIndexManager;
    import com.ankamagames.jerakine.types.Swl;

    public class AnimLibrary extends GraphicLibrary 
    {

        public function AnimLibrary(pGfxId:uint, isBone:Boolean=false)
        {
            super(pGfxId, isBone);
        }

        override public function addSwl(swl:Swl, url:String):void
        {
            var className:String;
            var animInfo:Array;
            super.addSwl(swl, url);
            for each (className in swl.getDefinitions())
            {
                if (className.indexOf("_to_") != -1)
                {
                    animInfo = className.split("_");
                    BoneIndexManager.getInstance().addTransition(gfxId, animInfo[0], animInfo[2], parseInt(animInfo[3]), ((animInfo[0] + "_to_") + animInfo[2]));
                };
            };
        }


    }
}//package com.ankamagames.tiphon.types

