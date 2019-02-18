#pragma once

#include <windows.h>
//#include "Img.h"

#pragma comment(lib, "vfw32.lib")
#include <vfw.h>



class CVideo
{
private:

	PAVIFILE m_pFile;
	PAVISTREAM m_pAviStream;
	PGETFRAME m_pGetFrame;


	int m_iWidth, m_iHeight;
	int m_iNbImages;
	int m_iRate;
	int m_iSizeImageData;
	int m_FourCC;


	//initialize 
	void Init(void);


public:
	//constructeur
	CVideo(void);
	
	//destructeur
	~CVideo(void);
	
	//ouvrir une video
	BOOL OpenVideo(const char* strFichier);

	//fermer la video
	void CloseVideo(void);

	//ouverte ?
	BOOL IsOpen(void) const;

	unsigned char* GetDataImage(int iNumImage) const;
	void GetDataImage(unsigned char* pDataImageRGB, int iNumImage) const;

	//CImg* GetImage(int iNumImage) const;
	
	int GetSizeImagedata() const;
	int GetWidth() const;
	int GetHeight() const;

	char* GetCodec(void) const;


private:
	void TransformDIB2MatlabData(unsigned char* pDataMatlab, const unsigned char* pDataBmpBGR) const;
	int memcopy_without_padding(unsigned char* pDataRGB, const unsigned char* pDIB, int iSize=0) const;


};

