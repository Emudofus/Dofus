package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterToRemodelInformations;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class CharactersListWithRemodelingMessage extends CharactersListMessage implements INetworkMessage
   {
      
      public function CharactersListWithRemodelingMessage()
      {
         this.charactersToRemodel = new Vector.<CharacterToRemodelInformations>();
         super();
      }
      
      public static const protocolId:uint = 6550;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var charactersToRemodel:Vector.<CharacterToRemodelInformations>;
      
      override public function getMessageId() : uint
      {
         return 6550;
      }
      
      public function initCharactersListWithRemodelingMessage(param1:Vector.<CharacterBaseInformations> = null, param2:Boolean = false, param3:Vector.<CharacterToRemodelInformations> = null) : CharactersListWithRemodelingMessage
      {
         super.initCharactersListMessage(param1,param2);
         this.charactersToRemodel = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.charactersToRemodel = new Vector.<CharacterToRemodelInformations>();
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
         this.serializeAs_CharactersListWithRemodelingMessage(param1);
      }
      
      public function serializeAs_CharactersListWithRemodelingMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_CharactersListMessage(param1);
         param1.writeShort(this.charactersToRemodel.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.charactersToRemodel.length)
         {
            (this.charactersToRemodel[_loc2_] as CharacterToRemodelInformations).serializeAs_CharacterToRemodelInformations(param1);
            _loc2_++;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_CharactersListWithRemodelingMessage(param1);
      }
      
      public function deserializeAs_CharactersListWithRemodelingMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:CharacterToRemodelInformations = null;
         super.deserialize(param1);
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new CharacterToRemodelInformations();
            _loc4_.deserialize(param1);
            this.charactersToRemodel.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
