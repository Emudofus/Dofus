package com.ankamagames.berilia.utils
{
   import nochump.util.zip.ZipFile;
   import nochump.util.zip.ZipEntry;
   import flash.filesystem.File;
   import flash.filesystem.FileStream;
   import flash.utils.ByteArray;
   import flash.filesystem.FileMode;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.berilia.BeriliaConstants;
   import com.ankamagames.jerakine.utils.crypto.Signature;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import flash.utils.Dictionary;
   import by.blooddy.crypto.MD5;
   import com.ankamagames.jerakine.resources.adapters.impl.SignedFileAdapter;
   import org.as3commons.bytecode.tags.DoABCTag;
   import org.as3commons.bytecode.abc.AbcFile;
   import org.as3commons.bytecode.abc.ClassInfo;
   import org.as3commons.bytecode.tags.FileAttributesTag;
   import org.as3commons.bytecode.swf.SWFFileIO;
   import org.as3commons.bytecode.swf.SWFFile;
   
   public class ModuleInspector extends Object
   {
      
      public function ModuleInspector()
      {
         super();
      }
      
      public static const whiteList:Array = new Array("dm","swf","xml","txt","png","jpg","css");
      
      public static function checkArchiveValidity(param1:ZipFile) : Boolean
      {
         var _loc3_:ZipEntry = null;
         var _loc4_:* = 0;
         var _loc5_:String = null;
         var _loc2_:* = 0;
         for each(_loc3_ in param1.entries)
         {
            _loc4_ = _loc3_.name.lastIndexOf(".");
            _loc5_ = _loc3_.name.substring(_loc4_ + 1);
            if(!_loc3_.isDirectory() && whiteList.indexOf(_loc5_) == -1)
            {
               return false;
            }
            _loc2_ = _loc2_ + _loc3_.size;
         }
         return _loc2_ < ModuleFileManager.MAX_FILE_SIZE && param1.size < ModuleFileManager.MAX_FILE_NUM;
      }
      
      public static function getDmFile(param1:File) : XML
      {
         var _loc2_:File = null;
         var _loc4_:XML = null;
         var _loc5_:FileStream = null;
         var _loc3_:ByteArray = new ByteArray();
         if(param1.exists)
         {
            for each(_loc2_ in param1.getDirectoryListing())
            {
               if(!_loc2_.isDirectory)
               {
                  if(_loc2_.type == ".dm")
                  {
                     if(_loc2_.name.lastIndexOf("/") != -1)
                     {
                        return null;
                     }
                     _loc5_ = new FileStream();
                     _loc5_.open(File(_loc2_),FileMode.READ);
                     _loc5_.readBytes(_loc3_,0,_loc5_.bytesAvailable);
                     _loc5_.close();
                     _loc4_ = new XML(_loc3_.readUTFBytes(_loc3_.bytesAvailable));
                     return _loc4_;
                  }
               }
            }
         }
         return null;
      }
      
      public static function getZipDmFile(param1:ZipFile) : XML
      {
         var _loc2_:ZipEntry = null;
         var _loc4_:XML = null;
         var _loc5_:* = 0;
         var _loc6_:String = null;
         var _loc3_:ByteArray = new ByteArray();
         for each(_loc2_ in param1.entries)
         {
            if(!_loc2_.isDirectory())
            {
               _loc5_ = _loc2_.name.lastIndexOf(".");
               _loc6_ = _loc2_.name.substring(_loc5_ + 1);
               if(_loc6_.toLowerCase() == "dm")
               {
                  if(_loc2_.name.lastIndexOf("/") != -1)
                  {
                     return null;
                  }
                  _loc3_ = ZipFile(param1).getInput(_loc2_);
                  _loc4_ = new XML(_loc3_.readUTFBytes(_loc3_.bytesAvailable));
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      public static function isModuleEnabled(param1:String, param2:Boolean) : Boolean
      {
         var _loc4_:* = false;
         var _loc3_:* = StoreDataManager.getInstance().getData(BeriliaConstants.DATASTORE_MOD,param1);
         if(_loc3_ == null)
         {
            _loc4_ = param2;
         }
         else
         {
            _loc4_ = (_loc3_) || (param2);
         }
         return _loc4_;
      }
      
      public static function checkIfModuleTrusted(param1:String) : Boolean
      {
         var _loc4_:FileStream = null;
         var _loc5_:ByteArray = null;
         var _loc6_:ByteArray = null;
         var _loc7_:Signature = null;
         var _loc2_:File = new File(param1);
         var _loc3_:Dictionary = UiModuleManager.getInstance().modulesHashs;
         if(_loc2_.exists)
         {
            _loc4_ = new FileStream();
            _loc4_.open(_loc2_,FileMode.READ);
            _loc5_ = new ByteArray();
            _loc4_.readBytes(_loc5_);
            _loc4_.close();
            if(_loc2_.type == ".swf")
            {
               return MD5.hashBytes(_loc5_) == _loc3_[_loc2_.name];
            }
            if(_loc2_.type == ".swfs")
            {
               _loc6_ = new ByteArray();
               _loc7_ = new Signature(SignedFileAdapter.defaultSignatureKey);
               return _loc7_.verify(_loc5_,_loc6_);
            }
         }
         return false;
      }
      
      public static function getScriptHookAndAction(param1:ByteArray) : Object
      {
         var _loc4_:DoABCTag = null;
         var _loc5_:AbcFile = null;
         var _loc6_:ClassInfo = null;
         var _loc7_:FileAttributesTag = null;
         var _loc9_:Array = null;
         var _loc2_:* = new Object();
         var _loc3_:SWFFileIO = new SWFFileIO();
         var _loc8_:SWFFile = _loc3_.read(param1);
         _loc2_.actions = new Array();
         _loc2_.apis = new Array();
         _loc2_.hooks = new Array();
         for each(_loc4_ in _loc8_.getTagsByType(DoABCTag))
         {
            _loc5_ = _loc4_.abcFile;
            for each(_loc6_ in _loc5_.classInfo)
            {
               switch(_loc6_.classMultiname.nameSpace.name)
               {
                  case "d2hooks":
                     _loc2_.hooks.push(_loc6_.classMultiname.name);
                     continue;
                  case "d2actions":
                     _loc2_.actions.push(_loc6_.classMultiname.name);
                     continue;
                  case "d2api":
                     _loc2_.apis.push(_loc6_.classMultiname.name);
                     continue;
                  default:
                     continue;
               }
            }
         }
         _loc9_ = _loc8_.getTagsByType(FileAttributesTag);
         for each(_loc7_ in _loc9_)
         {
            _loc2_.useNetwork = _loc7_.useNetwork;
         }
         return _loc2_;
      }
   }
}
