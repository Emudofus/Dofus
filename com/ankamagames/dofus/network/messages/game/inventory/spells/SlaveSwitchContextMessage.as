package com.ankamagames.dofus.network.messages.game.inventory.spells
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.data.items.SpellItem;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class SlaveSwitchContextMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function SlaveSwitchContextMessage() {
         this.slaveSpells=new Vector.<SpellItem>();
         this.slaveStats=new CharacterCharacteristicsInformations();
         super();
      }

      public static const protocolId:uint = 6214;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var summonerId:int = 0;

      public var slaveId:int = 0;

      public var slaveSpells:Vector.<SpellItem>;

      public var slaveStats:CharacterCharacteristicsInformations;

      override public function getMessageId() : uint {
         return 6214;
      }

      public function initSlaveSwitchContextMessage(summonerId:int=0, slaveId:int=0, slaveSpells:Vector.<SpellItem>=null, slaveStats:CharacterCharacteristicsInformations=null) : SlaveSwitchContextMessage {
         this.summonerId=summonerId;
         this.slaveId=slaveId;
         this.slaveSpells=slaveSpells;
         this.slaveStats=slaveStats;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.summonerId=0;
         this.slaveId=0;
         this.slaveSpells=new Vector.<SpellItem>();
         this.slaveStats=new CharacterCharacteristicsInformations();
         this._isInitialized=false;
      }

      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }

      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }

      public function serialize(output:IDataOutput) : void {
         this.serializeAs_SlaveSwitchContextMessage(output);
      }

      public function serializeAs_SlaveSwitchContextMessage(output:IDataOutput) : void {
         output.writeInt(this.summonerId);
         output.writeInt(this.slaveId);
         output.writeShort(this.slaveSpells.length);
         var _i3:uint = 0;
         while(_i3<this.slaveSpells.length)
         {
            (this.slaveSpells[_i3] as SpellItem).serializeAs_SpellItem(output);
            _i3++;
         }
         this.slaveStats.serializeAs_CharacterCharacteristicsInformations(output);
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SlaveSwitchContextMessage(input);
      }

      public function deserializeAs_SlaveSwitchContextMessage(input:IDataInput) : void {
         var _item3:SpellItem = null;
         this.summonerId=input.readInt();
         this.slaveId=input.readInt();
         var _slaveSpellsLen:uint = input.readUnsignedShort();
         var _i3:uint = 0;
         while(_i3<_slaveSpellsLen)
         {
            _item3=new SpellItem();
            _item3.deserialize(input);
            this.slaveSpells.push(_item3);
            _i3++;
         }
         this.slaveStats=new CharacterCharacteristicsInformations();
         this.slaveStats.deserialize(input);
      }
   }

}