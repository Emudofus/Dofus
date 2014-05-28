package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterToRecolorInformation;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterToRelookInformation;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharactersListWithModificationsMessage extends CharactersListMessage implements INetworkMessage
   {
      
      public function CharactersListWithModificationsMessage() {
         this.charactersToRecolor = new Vector.<CharacterToRecolorInformation>();
         this.charactersToRename = new Vector.<int>();
         this.unusableCharacters = new Vector.<int>();
         this.charactersToRelook = new Vector.<CharacterToRelookInformation>();
         super();
      }
      
      public static const protocolId:uint = 6120;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var charactersToRecolor:Vector.<CharacterToRecolorInformation>;
      
      public var charactersToRename:Vector.<int>;
      
      public var unusableCharacters:Vector.<int>;
      
      public var charactersToRelook:Vector.<CharacterToRelookInformation>;
      
      override public function getMessageId() : uint {
         return 6120;
      }
      
      public function initCharactersListWithModificationsMessage(characters:Vector.<CharacterBaseInformations> = null, hasStartupActions:Boolean = false, charactersToRecolor:Vector.<CharacterToRecolorInformation> = null, charactersToRename:Vector.<int> = null, unusableCharacters:Vector.<int> = null, charactersToRelook:Vector.<CharacterToRelookInformation> = null) : CharactersListWithModificationsMessage {
         super.initCharactersListMessage(characters,hasStartupActions);
         this.charactersToRecolor = charactersToRecolor;
         this.charactersToRename = charactersToRename;
         this.unusableCharacters = unusableCharacters;
         this.charactersToRelook = charactersToRelook;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.charactersToRecolor = new Vector.<CharacterToRecolorInformation>();
         this.charactersToRename = new Vector.<int>();
         this.unusableCharacters = new Vector.<int>();
         this.charactersToRelook = new Vector.<CharacterToRelookInformation>();
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharactersListWithModificationsMessage(output);
      }
      
      public function serializeAs_CharactersListWithModificationsMessage(output:IDataOutput) : void {
         super.serializeAs_CharactersListMessage(output);
         output.writeShort(this.charactersToRecolor.length);
         var _i1:uint = 0;
         while(_i1 < this.charactersToRecolor.length)
         {
            (this.charactersToRecolor[_i1] as CharacterToRecolorInformation).serializeAs_CharacterToRecolorInformation(output);
            _i1++;
         }
         output.writeShort(this.charactersToRename.length);
         var _i2:uint = 0;
         while(_i2 < this.charactersToRename.length)
         {
            output.writeInt(this.charactersToRename[_i2]);
            _i2++;
         }
         output.writeShort(this.unusableCharacters.length);
         var _i3:uint = 0;
         while(_i3 < this.unusableCharacters.length)
         {
            output.writeInt(this.unusableCharacters[_i3]);
            _i3++;
         }
         output.writeShort(this.charactersToRelook.length);
         var _i4:uint = 0;
         while(_i4 < this.charactersToRelook.length)
         {
            (this.charactersToRelook[_i4] as CharacterToRelookInformation).serializeAs_CharacterToRelookInformation(output);
            _i4++;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharactersListWithModificationsMessage(input);
      }
      
      public function deserializeAs_CharactersListWithModificationsMessage(input:IDataInput) : void {
         var _item1:CharacterToRecolorInformation = null;
         var _val2:* = 0;
         var _val3:* = 0;
         var _item4:CharacterToRelookInformation = null;
         super.deserialize(input);
         var _charactersToRecolorLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _charactersToRecolorLen)
         {
            _item1 = new CharacterToRecolorInformation();
            _item1.deserialize(input);
            this.charactersToRecolor.push(_item1);
            _i1++;
         }
         var _charactersToRenameLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _charactersToRenameLen)
         {
            _val2 = input.readInt();
            this.charactersToRename.push(_val2);
            _i2++;
         }
         var _unusableCharactersLen:uint = input.readUnsignedShort();
         var _i3:uint = 0;
         while(_i3 < _unusableCharactersLen)
         {
            _val3 = input.readInt();
            this.unusableCharacters.push(_val3);
            _i3++;
         }
         var _charactersToRelookLen:uint = input.readUnsignedShort();
         var _i4:uint = 0;
         while(_i4 < _charactersToRelookLen)
         {
            _item4 = new CharacterToRelookInformation();
            _item4.deserialize(input);
            this.charactersToRelook.push(_item4);
            _i4++;
         }
      }
   }
}
