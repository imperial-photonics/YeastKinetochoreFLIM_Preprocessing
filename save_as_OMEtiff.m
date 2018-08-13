function save_as_OMEtiff(outputPath, data, delays)

% initialize logging
loci.common.DebugTools.enableLogging('ERROR');

java.lang.System.setProperty('javax.xml.transform.TransformerFactory', 'com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl');

metadata = createMinimalOMEXMLMetadata(data);

%metadata.setXMLAnnotationID('Annotation:Modulo:0', 0);
%metadata.setXMLAnnotationNamespace('openmicroscopy.org/omero/dimension/modulo', 0);

modlo = loci.formats.CoreMetadata();

modlo.moduloT.type = loci.formats.FormatTools.LIFETIME;
modlo.moduloT.unit = 'ps';
% replace with 'TCSPC' if appropriate
modlo.moduloT.typeDescription = 'Gated';

modlo.moduloT.labels = javaArray('java.lang.String',length(delays));
for i=1:length(delays)
    modlo.moduloT.labels(i)= java.lang.String(num2str(delays(i)));
end

OMEXMLService = loci.formats.services.OMEXMLServiceImpl();

OMEXMLService.addModuloAlong(metadata,modlo,0);

if exist(outputPath, 'file') == 2
    delete(outputPath);
end
bfsave(data, outputPath, 'metadata', metadata);


