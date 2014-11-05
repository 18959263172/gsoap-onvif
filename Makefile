#�����base·��
CC = g++
CPPFLAG = -Wall -Werror -g -w -fPIC -DWITH_NONAMESPACES -fno-use-cxa-atexit -fexceptions -DWITH_DOM  -DWITH_OPENSSL -DSOAP_DEBUG  

BASE_DIR=.
GSOAP_DIR=/root/gsoap-2.8/gsoap
SOURCE=$(BASE_DIR)
SOURCE_CODE=../../..
#include path
INCLUDE +=-I$(SOURCE)/include -I$(GSOAP_DIR) -I$(GSOAP_DIR)/src  -I$(GSOAP_DIR)/import  -I$(BASE_DIR) 
#link path
LIB= -L../../release/lib -L/nvrs/lib -lssl -lcrypto
#proxy obj
PROXYSOURCE=$(BASE_DIR)/proxycpp
ProxyOBJ=$(PROXYSOURCE)/soapDeviceBindingProxy.o $(PROXYSOURCE)/soapMediaBindingProxy.o 
PluginSOURCE=$(BASE_DIR)/plugin
PluginOBJ=$(PluginSOURCE)/wsaapi.o $(PluginSOURCE)/wsseapi.o $(PluginSOURCE)/threads.o $(PluginSOURCE)/duration.o \
		  $(PluginSOURCE)/smdevp.o $(PluginSOURCE)/mecevp.o $(PluginSOURCE)/dom.o

SRC= $(SOURCE)/stdsoap2.o  $(SOURCE)/soapC.o $(SOURCE)/soapClient.o $(SOURCE)/main.o $(PluginOBJ) $(ProxyOBJ)

#Ŀ��.o�ļ����ɹ���
OBJECTS = $(patsubst %.cpp,%.o,$(SRC))


#Ŀ�����
TARGET=libipc.so

#CPPFLAG = -Wall  -g   -DWITH_OPENSSL 

all: $(TARGET) 
  
$(TARGET):$(OBJECTS) 
	$(CC) $(CPPFLAG) -shared $(OBJECTS)  $(INCLUDE)  $(LIB) -o $(TARGET)

$(OBJECTS):%.o : %.cpp
	$(CC) -c $(CPPFLAG) $(INCLUDE) $< -o $@
  
clean:
	rm -rf  $(OBJECTS) 

