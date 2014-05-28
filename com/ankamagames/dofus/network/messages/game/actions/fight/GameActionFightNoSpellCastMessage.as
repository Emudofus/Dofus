package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightNoSpellCastMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameActionFightNoSpellCastMessage() {
         super();
      }
      
      public static const protocolId:uint = 6132;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var spellLevelId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6132;
      }
      
      public function initGameActionFightNoSpellCastMessage(spellLevelId:uint = 0) : GameActionFightNoSpellCastMessage {
         this.spellLevelId = spellLevelId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.spellLevelId = 0;
         this._isInitialized = false;
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
         this.serializeAs_GameActionFightNoSpellCastMessage(output);
      }
      
      public function serializeAs_GameActionFightNoSpellCastMessage(output:IDataOutput) : void {
         if(this.spellLevelId < 0)
         {
            throw new Error("Forbidden value (" + this.spellLevelId + ") on element spellLevelId.");
         }
         else
         {
            output.writeInt(this.spellLevelId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameActionFightNoSpellCastMessage(input);
      }
      
      public function deserializeAs_GameActionFightNoSpellCastMessage(input:IDataInput) : void {
         this.spellLevelId = input.readInt();
         if(this.spellLevelId < 0)
         {
            throw new Error("Forbidden value (" + this.spellLevelId + ") on element of GameActionFightNoSpellCastMessage.spellLevelId.");
         }
         else
         {
            return;
         }
      }
   }
}
