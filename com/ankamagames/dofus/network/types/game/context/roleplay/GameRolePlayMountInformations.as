package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameRolePlayMountInformations extends GameRolePlayNamedActorInformations implements INetworkType
   {
      
      public function GameRolePlayMountInformations() {
         super();
      }
      
      public static const protocolId:uint = 180;
      
      public var ownerName:String = "";
      
      public var level:uint = 0;
      
      override public function getTypeId() : uint {
         return 180;
      }
      
      public function initGameRolePlayMountInformations(contextualId:int=0, look:EntityLook=null, disposition:EntityDispositionInformations=null, name:String="", ownerName:String="", level:uint=0) : GameRolePlayMountInformations {
         super.initGameRolePlayNamedActorInformations(contextualId,look,disposition,name);
         this.ownerName = ownerName;
         this.level = level;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.ownerName = "";
         this.level = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameRolePlayMountInformations(output);
      }
      
      public function serializeAs_GameRolePlayMountInformations(output:IDataOutput) : void {
         super.serializeAs_GameRolePlayNamedActorInformations(output);
         output.writeUTF(this.ownerName);
         if((this.level < 0) || (this.level > 255))
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            output.writeByte(this.level);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayMountInformations(input);
      }
      
      public function deserializeAs_GameRolePlayMountInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.ownerName = input.readUTF();
         this.level = input.readUnsignedByte();
         if((this.level < 0) || (this.level > 255))
         {
            throw new Error("Forbidden value (" + this.level + ") on element of GameRolePlayMountInformations.level.");
         }
         else
         {
            return;
         }
      }
   }
}
