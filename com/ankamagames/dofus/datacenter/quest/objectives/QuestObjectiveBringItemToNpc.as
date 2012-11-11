package com.ankamagames.dofus.datacenter.quest.objectives
{
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.utils.pattern.*;

    public class QuestObjectiveBringItemToNpc extends QuestObjective implements IDataCenter
    {
        private var _npc:Npc;
        private var _item:Item;
        private var _text:String;

        public function QuestObjectiveBringItemToNpc()
        {
            return;
        }// end function

        public function get npcId() : uint
        {
            if (!this.parameters)
            {
                return 0;
            }
            return this.parameters[0];
        }// end function

        public function get npc() : Npc
        {
            if (!this._npc)
            {
                this._npc = Npc.getNpcById(this.npcId);
            }
            return this._npc;
        }// end function

        public function get itemId() : uint
        {
            if (!this.parameters)
            {
                return 0;
            }
            return this.parameters[1];
        }// end function

        public function get item() : Item
        {
            if (!this._item)
            {
                this._item = Item.getItemById(this.itemId);
            }
            return this._item;
        }// end function

        public function get quantity() : uint
        {
            if (!this.parameters)
            {
                return 0;
            }
            return this.parameters[2];
        }// end function

        override public function get text() : String
        {
            if (!this._text)
            {
                this._text = PatternDecoder.getDescription(this.type.name, [this.npc.name, this.item.name, this.quantity]);
            }
            return this._text;
        }// end function

    }
}
