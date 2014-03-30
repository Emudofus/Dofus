package com.ankamagames.dofus.modules.utils
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
      
      public function ModuleInspector() {
         super();
      }
      
      public static function checkArchiveValidity(archive:ZipFile) : Boolean {
         var entry:ZipEntry = null;
         var totalSize:int = 0;
         for each (entry in archive.entries)
         {
            totalSize = totalSize + entry.size;
         }
         return (totalSize < ModuleFileManager.MAX_FILE_SIZE) && (archive.size < ModuleFileManager.MAX_FILE_NUM);
      }
      
      public static function getDmFile(targetFile:File) : XML {
         var entry:File = null;
         var dmData:XML = null;
         var rfs:FileStream = null;
         var rawData:ByteArray = new ByteArray();
         for each (entry in targetFile.getDirectoryListing())
         {
            if(!entry.isDirectory)
            {
               if(entry.type == ".dm")
               {
                  if(entry.name.lastIndexOf("/") != -1)
                  {
                     return null;
                  }
                  rfs = new FileStream();
                  rfs.open(File(entry),FileMode.READ);
                  rfs.readBytes(rawData,0,rfs.bytesAvailable);
                  rfs.close();
                  dmData = new XML(rawData.readUTFBytes(rawData.bytesAvailable));
                  return dmData;
               }
            }
         }
         return null;
      }
      
      public static function getZipDmFile(targetFile:ZipFile) : XML {
         var entry:ZipEntry = null;
         var dmData:XML = null;
         var dotIndex:* = 0;
         var fileType:String = null;
         var rawData:ByteArray = new ByteArray();
         for each (entry in targetFile.entries)
         {
            if(!entry.isDirectory())
            {
               dotIndex = entry.name.lastIndexOf(".");
               fileType = entry.name.substring(dotIndex + 1);
               if(fileType.toLowerCase() == "dm")
               {
                  if(entry.name.lastIndexOf("/") != -1)
                  {
                     return null;
                  }
                  rawData = ZipFile(targetFile).getInput(entry);
                  dmData = new XML(rawData.readUTFBytes(rawData.bytesAvailable));
                  return dmData;
               }
            }
         }
         return null;
      }
      
      public static function isModuleEnabled(moduleId:String, trusted:Boolean) : Boolean {
         var enable:* = false;
         var state:* = StoreDataManager.getInstance().getData(BeriliaConstants.DATASTORE_MOD,moduleId);
         if(state == null)
         {
            enable = trusted;
         }
         else
         {
            enable = (state) || (trusted);
         }
         return enable;
      }
      
      public static function checkIfModuleTrusted(filePath:String) : Boolean {
         var fs:FileStream = null;
         var swfContent:ByteArray = null;
         var fooOutput:ByteArray = null;
         var sig:Signature = null;
         var scriptFile:File = new File(filePath);
         var modulesHashs:Dictionary = UiModuleManager.getInstance().modulesHashs;
         if(scriptFile.exists)
         {
            fs = new FileStream();
            fs.open(scriptFile,FileMode.READ);
            swfContent = new ByteArray();
            fs.readBytes(swfContent);
            fs.close();
            if(scriptFile.type == ".swf")
            {
               return MD5.hashBytes(swfContent) == modulesHashs[scriptFile.name];
            }
            if(scriptFile.type == ".swfs")
            {
               fooOutput = new ByteArray();
               sig = new Signature(SignedFileAdapter.defaultSignatureKey);
               return sig.verify(swfContent,fooOutput);
            }
         }
         return false;
      }
      
      public static function getScriptHookAndAction(swfContent:ByteArray) : Object {
         var tag:DoABCTag = null;
         var abcFile:AbcFile = null;
         var infos:ClassInfo = null;
         var attributesTag:FileAttributesTag = null;
         var fileAttributesTags:Array = null;
         var apiHookAction:* = new Object();
         var io:SWFFileIO = new SWFFileIO();
         var swfFile:SWFFile = io.read(swfContent);
         apiHookAction.actions = new Array();
         apiHookAction.apis = new Array();
         apiHookAction.hooks = new Array();
         for each (tag in swfFile.getTagsByType(DoABCTag))
         {
            abcFile = tag.abcFile;
            for each (infos in abcFile.classInfo)
            {
               switch(infos.classMultiname.nameSpace.name)
               {
                  case "d2hooks":
                     apiHookAction.hooks.push(infos.classMultiname.name);
                     continue;
                  case "d2actions":
                     apiHookAction.actions.push(infos.classMultiname.name);
                     continue;
                  case "d2api":
                     apiHookAction.apis.push(infos.classMultiname.name);
                     continue;
               }
            }
         }
         fileAttributesTags = swfFile.getTagsByType(FileAttributesTag);
         for each (attributesTag in fileAttributesTags)
         {
            apiHookAction.useNetwork = attributesTag.useNetwork;
         }
         return apiHookAction;
      }
   }
}
