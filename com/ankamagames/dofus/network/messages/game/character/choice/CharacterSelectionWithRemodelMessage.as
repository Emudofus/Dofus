package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.choice.RemodelingInformation;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class CharacterSelectionWithRemodelMessage extends CharacterSelectionMessage implements INetworkMessage
   {
      
      public function CharacterSelectionWithRemodelMessage()
      {
         this.remodel = new RemodelingInformation();
         super();
      }
      
      public static const protocolId:uint = 6549;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var remodel:RemodelingInformation;
      
      override public function getMessageId() : uint
      {
         return 6549;
      }
      
      public function initCharacterSelectionWithRemodelMessage(param1:int = 0, param2:RemodelingInformation = null) : CharacterSelectionWithRemodelMessage
      {
         super.initCharacterSelectionMessage(param1);
         this.remodel = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.remodel = new RemodelingInformation();
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
         this.serializeAs_CharacterSelectionWithRemodelMessage(param1);
      }
      
      public function serializeAs_CharacterSelectionWithRemodelMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterSelectionMessage(param1);
         this.remodel.serializeAs_RemodelingInformation(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterSelectionWithRemodelMessage(param1);
      }
      
      public function deserializeAs_CharacterSelectionWithRemodelMessage(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.remodel = new RemodelingInformation();
         this.remodel.deserialize(param1);
      }
   }
}
