package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import __AS3__.vec.Vector;

    public class CharacterRemodelSelectionAction implements Action 
    {

        public var id:int;
        public var sex:Boolean;
        public var breed:uint;
        public var cosmeticId:uint;
        public var name:String;
        public var colors:Vector.<int>;


        public static function create(id:int, sex:Boolean, breed:uint, cosmeticId:uint, name:String, colors:Vector.<int>):CharacterRemodelSelectionAction
        {
            var a:CharacterRemodelSelectionAction = new (CharacterRemodelSelectionAction)();
            a.id = id;
            a.sex = sex;
            a.breed = breed;
            a.cosmeticId = cosmeticId;
            a.name = name;
            a.colors = colors;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.approach.actions

