package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.character.restriction.ActorRestrictionsInformations;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class HumanInformations extends Object implements INetworkType
   {
      
      public function HumanInformations() {
         this.restrictions = new ActorRestrictionsInformations();
         this.options = new Vector.<HumanOption>();
         super();
      }
      
      public static const protocolId:uint = 157;
      
      public var restrictions:ActorRestrictionsInformations;
      
      public var sex:Boolean = false;
      
      public var options:Vector.<HumanOption>;
      
      public function getTypeId() : uint {
         return 157;
      }
      
      public function initHumanInformations(restrictions:ActorRestrictionsInformations=null, sex:Boolean=false, options:Vector.<HumanOption>=null) : HumanInformations {
         this.restrictions = restrictions;
         this.sex = sex;
         this.options = options;
         return this;
      }
      
      public function reset() : void {
         this.restrictions = new ActorRestrictionsInformations();
         this.options = new Vector.<HumanOption>();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_HumanInformations(output);
      }
      
      public function serializeAs_HumanInformations(output:IDataOutput) : void {
         this.restrictions.serializeAs_ActorRestrictionsInformations(output);
         output.writeBoolean(this.sex);
         output.writeShort(this.options.length);
         var _i3:uint = 0;
         while(_i3 < this.options.length)
         {
            output.writeShort((this.options[_i3] as HumanOption).getTypeId());
            (this.options[_i3] as HumanOption).serialize(output);
            _i3++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HumanInformations(input);
      }
      
      public function deserializeAs_HumanInformations(input:IDataInput) : void {
         var _id3:uint = 0;
         var _item3:HumanOption = null;
         this.restrictions = new ActorRestrictionsInformations();
         this.restrictions.deserialize(input);
         this.sex = input.readBoolean();
         var _optionsLen:uint = input.readUnsignedShort();
         var _i3:uint = 0;
         while(_i3 < _optionsLen)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(HumanOption,_id3);
            _item3.deserialize(input);
            this.options.push(_item3);
            _i3++;
         }
      }
   }
}
