SELECT tblROP3people2019_ROP3, STRING_AGG(PEID, ', ') PEIDs INTO PEIDsTable
FROM Etnopedia
GROUP BY tblROP3people2019_ROP3;
SELECT tblROP3people2019_ROP3, STRING_AGG(WCDPRN, ', ') WCDPRNs INTO WCCPRNTable
FROM Etnopedia
GROUP BY tblROP3people2019_ROP3;
SELECT tblROP3people2019_ROP3,
       SUM(CAST(JPLPop AS BIGINT)) JPLPop,
       SUM(CAST(OWPop AS BIGINT)) OWPop,
       SUM(CAST(AMOPop AS BIGINT)) AMOPop,
       SUM(CAST(OmidPop AS BIGINT)) OmidPop,
       SUM(CAST(CPPIPop AS BIGINT)) CPPIPop,
       SUM(CAST(WCDPop AS BIGINT)) WCDPop,
       SUM(CAST(EthnoPop AS BIGINT)) EthnoPop
INTO totalPopSeparated
FROM Etnopedia GROUP BY tblROP3people2019_ROP3;
SELECT tblROP3people2019_ROP3,
       COALESCE(JPLPop,0)
          + COALESCE(OWPop,0)
          + COALESCE(AMOPop,0)
          + COALESCE(OmidPop,0)
          + COALESCE(CPPIPop,0)
           +  COALESCE(WCDPop,0)
           + COALESCE(EthnoPop,0) totalPOP INTO totalPOPtable FROM totalPopSeparated
GROUP BY tblROP3people2019_ROP3, JPLPop, OWPop, AMOPop, OmidPop, CPPIPop, WCDPop, EthnoPop;
SELECT Etnopedia.tblROP3people2019_ROP3,ROP2,PeopleName, EditDate, Etnopedia.PLOC AS "PLOC/ROG", tblROP3people2019_PROL, tblROP3geoIndex_PROL, tPS.totalPOP, PDT.PEIDs, WT.WCDPRNs
INTO Organized
FROM Etnopedia
    JOIN PEIDsTable PDT ON Etnopedia.tblROP3people2019_ROP3 = PDT.tblROP3people2019_ROP3
    JOIN WCCPRNTable WT on Etnopedia.tblROP3people2019_ROP3 = WT.tblROP3people2019_ROP3
    JOIN totalPoptable tPS on Etnopedia.tblROP3people2019_ROP3 = tPS.tblROP3people2019_ROP3
WHERE PLOC = ROG;
DROP TABLE PEIDsTable,WCCPRNTable,totalPopSeparated,totalPOPtable;
