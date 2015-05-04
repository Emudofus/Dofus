package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class CharactersListMessage extends BasicCharactersListMessage implements INetworkMessage
   {
      
      public function CharactersListMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 151;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var hasStartupActions:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 151;
      }
      
      public function initCharactersListMessage(param1:Vector.<CharacterBaseInformations> = null, param2:Boolean = false) : CharactersListMessage
      {
         super.initBasicCharactersListMessage(param1);
         this.hasStartupActions = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.hasStartupActions = false;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_CharactersListMessage(param1);
      }
      
      public function serializeAs_CharactersListMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_BasicCharactersListMessage(param1);
         param1.writeBoolean(this.hasStartupActions);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_CharactersListMessage(param1);
      }
      
      public function deserializeAs_CharactersListMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.hasStartupActions = param1.readBoolean();
      }
   }
}
