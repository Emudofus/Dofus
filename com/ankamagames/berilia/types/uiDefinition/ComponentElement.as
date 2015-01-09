package com.ankamagames.berilia.types.uiDefinition
{
    import flash.utils.Dictionary;

    public class ComponentElement extends BasicElement 
    {

        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public function ComponentElement()
        {
            MEMORY_LOG[this] = 1;
        }

    }
}//package com.ankamagames.berilia.types.uiDefinition

