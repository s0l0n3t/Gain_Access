Attribute VB_Name = "CH341PTDLL"
' 2005.07.28
'****************************************
'**  Copyright  (C)  W.ch  1999-2005   **
'**  Web:  http:'www.winchiphead.com  **
'****************************************
'**  DLL for USB interface chip CH341  **
'**  C, VC5.0                          **
'****************************************
'
' USB���߽ӿ�оƬCH341�˿�Ӧ�ò�ӿڿ� V1.0
' �Ͼ��ߺ�������޹�˾  ����: W.ch 2005.07
' CH341-Port-DLL  V1.0
' ���л���: Windows 98/ME, Windows 2000/XP
' support USB chip: CH341, CH341A
' USB => Serial, Parallel
'



Public Const MAX_DEVICE_PATH_SIZE = 128               ' �豸���Ƶ�����ַ���
Public Const MAX_DEVICE_ID_SIZE = 64                  ' �豸ID������ַ���

Declare Function CH341PtGetVersion Lib "CH341PT.DLL" () As Long   ' ���DLL�汾��,���ذ汾��

Declare Function CH341PtHandleIsCH341 Lib "CH341PT.DLL" (ByVal iPortHandle As Long) As Boolean   ' ָ���Ѿ��򿪵Ķ˿ھ��
'    CH341PtHandleIsCH341   ����Ѿ��򿪵Ķ˿��Ƿ�ΪCH341�˿�
'    iPortHandle   '        ָ���Ѿ��򿪵Ķ˿ھ��

Declare Function CH341PtNameIsCH341 Lib "CH341PT.DLL" (ByVal iPortName As String) As Boolean
'    CH341PtNameIsCH341    ���ָ�����ƵĶ˿��Ƿ�ΪCH341�˿�
'    iPortName             ָ���˿�����,����"COM3","COM15"��,�ö˿ڱ���δ��ռ��(ָδ�����������)

' �˿��豸�¼�֪ͨ�ص�����
' sub mPCH341PT_NOTIFY_ROUTINE  (byval iDevIndexAndEvent as long)  ' �˿��豸��ź��¼�����ǰ״̬(�ο�����˵��)
' iDevIndexAndEvent: ����˵�����豸�����¼�/�Ѿ�����, ����˵�����豸�γ��¼�/�Ѿ��γ�, �����ֵ���豸���(1��255)

Declare Function CH341PtSetDevNotify Lib "CH341PT.DLL" (ByVal iDeviceID As String, ByVal iNotifyRoutine As Long) As Boolean       ' ָ���˿��豸�¼��ص�����,ΪNULL��ȡ���¼�֪ͨ,�����ڼ�⵽�¼�ʱ���øó���
'    CH341PtSetDevNotify      �趨�˿��豸�¼�֪ͨ����
'    iDeviceID,               ��ѡ����,ָ����\0��ֹ���ַ���,ָ������ص��豸��ID���߲�����ŵ�������,���ڴ��ڸò�������ΪNULL����"COM"
'    iNotifyRoutine           ָ���˿��豸�¼��ص�����,ΪNULL��ȡ���¼�֪ͨ,�����ڼ�⵽�¼�ʱ���øó���

'/* ���弴���豸��Ӧ�ó����̲ο�
'1. ������������Ĭ���ǽ�ֹ���ݴ���ģ�ֻ����ȷ����CH341�˿ڿ��ò��Ҵ򿪶˿ں�Ž������ݴ���
'2. ����CH341PtSetDevNotify���ò�μ��ӣ������������CH341�˿ڵĲ���¼�DLL�����Զ�����iNotifyRoutine��ָ�����ӳ�����ߺ���
'3. �Ӷ˿�1���˿�255��������20���ɣ��������CH341PtNameIsCH341ȷ���Ƿ�ΪCH341�˿ڣ�����������������˿ںŲ��򿪺�ʼ���䣬������ط�����Ϣ
'4. ���iNotifyRoutine�յ��¼�֪ͨ����ô�����ڱ����¼�������֪ͨ����������Ҳ�����ڸ��ӳ����д�����
'   �����¼������������������˵����һ���˿ڲ��룬��Ҫ��ʱӦ��������CH341PtNameIsCH341�ж��Ƿ�ΪCH341�˿ڣ����������˿ںŲ��򿪺�ʼ���䣬
'                 ����Ǹ�����˵����һ���˿ڰγ����ж���˿ںţ���0��ȥ�ø����ö˿ںţ��Ƿ��������Ѵ򿪵Ķ˿ں���ͬ������Ӧ�ü�ʱ�ر�
'5. ��ǰ�Ѿ��򿪵Ķ˿ں�Ӧ�ñ���Ϊȫ�ֱ���, ����˿�δ�򿪻��߱��رգ���ôӦ�ó���Ӧ��ֹͣ���ݴ���
'6. �������δ��CH341PtNameIsCH341ȷ���Ƿ�ΪCH341�˿ڣ���ô�ڶ˿��Ѿ��򿪺�Ҳ���Ե���CH341PtHandleIsCH341�ж��Ƿ�ΪCH341�˿�
'*/


