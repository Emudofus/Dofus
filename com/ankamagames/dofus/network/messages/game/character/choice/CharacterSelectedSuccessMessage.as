package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class CharacterSelectedSuccessMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterSelectedSuccessMessage()
      {
         this.infos = new CharacterBaseInformations();
         super();
      }
      
      public static const protocolId:uint = 153;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var infos:CharacterBaseInformations;
      
      public var isCollectingStats:Boolean = false;
      
      override public function getMessageId() : uint
      {
         return 153;
      }
      
      public function initCharacterSelectedSuccessMessage(param1:CharacterBaseInformations = null, param2:Boolean = false) : CharacterSelectedSuccessMessage
      {
         this.infos = param1;
         this.isCollectingStats = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.infos = new CharacterBaseInformations();
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
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterSelectedSuccessMessage(param1);
      }
      
      public function serializeAs_CharacterSelectedSuccessMessage(param1:ICustomDataOutput) : void
      {
         this.infos.serializeAs_CharacterBaseInformations(param1);
         param1.writeBoolean(this.isCollectingStats);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterSelectedSuccessMessage(param1);
      }
      
      public function deserializeAs_CharacterSelectedSuccessMessage(param1:ICustomDataInput) : void
      {
         this.infos = new CharacterBaseInformations();
         this.infos.deserialize(param1);
         this.isCollectingStats = param1.readBoolean();
      }
   }
}
