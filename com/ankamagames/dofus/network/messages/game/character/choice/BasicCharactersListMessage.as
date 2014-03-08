package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class BasicCharactersListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicCharactersListMessage() {
         this.characters = new Vector.<CharacterBaseInformations>();
         super();
      }
      
      public static const protocolId:uint = 6475;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var characters:Vector.<CharacterBaseInformations>;
      
      override public function getMessageId() : uint {
         return 6475;
      }
      
      public function initBasicCharactersListMessage(param1:Vector.<CharacterBaseInformations>=null) : BasicCharactersListMessage {
         this.characters = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.characters = new Vector.<CharacterBaseInformations>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_BasicCharactersListMessage(param1);
      }
      
      public function serializeAs_BasicCharactersListMessage(param1:IDataOutput) : void {
         param1.writeShort(this.characters.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.characters.length)
         {
            param1.writeShort((this.characters[_loc2_] as CharacterBaseInformations).getTypeId());
            (this.characters[_loc2_] as CharacterBaseInformations).serialize(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_BasicCharactersListMessage(param1);
      }
      
      public function deserializeAs_BasicCharactersListMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc5_:CharacterBaseInformations = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readUnsignedShort();
            _loc5_ = ProtocolTypeManager.getInstance(CharacterBaseInformations,_loc4_);
            _loc5_.deserialize(param1);
            this.characters.push(_loc5_);
            _loc3_++;
         }
      }
   }
}
