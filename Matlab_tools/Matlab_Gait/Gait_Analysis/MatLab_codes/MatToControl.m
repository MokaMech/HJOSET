function [outputArg1] = MatToControl(inputArg1,inputArg2,inputArg3,inputArg4,inputArg5)
%% Turns a Simulink 2D timeseries output into a OpenSim control file (excitation file) for actuators
%% I/O 
% outputArg1 : bool         flag that shows function has finish.
% inputArg1 : timeseries    N-long Time array
% inputArg2 : timeseries    N-long Values array
% inputArg3 : double        Time offset of the current MoCap
% Default argument to execute the code manualy : out.mechanismOutput.Time
% out.mechanismOutput.Data
%%

% Create an XML document.
    docNode = com.mathworks.xml.XMLUtils.createDocument('OpenSimDocument');
    docRootNode = docNode.getDocumentElement;
    docRootNode.setAttribute('Version','40000');
% Copy Header
    controlSet_node = docNode.createElement('ControlSet');
    controlSet_node.setAttribute('name','GIL_AFO_Controller');
    docNode.getDocumentElement.appendChild(controlSet_node);

        objects_node = docNode.createElement('objects');
        controlSet_node.appendChild(objects_node);
    
            controlLinear_node = docNode.createElement('ControlLinear');
            controlLinear_node.setAttribute('name','lAFO_torq_gen.excitation');
            objects_node.appendChild(controlLinear_node);
    
                model_control_node = docNode.createElement('is_model_control');
                model_control_text = docNode.createTextNode('true');
                model_control_node.appendChild(model_control_text);
                controlLinear_node.appendChild(model_control_node);
                extrapolate_node = docNode.createElement('extrapolate');
                extrapolate_text = docNode.createTextNode('false');
                extrapolate_node.appendChild(extrapolate_text);
                controlLinear_node.appendChild(extrapolate_node);
                default_min_node = docNode.createElement('default_min');
                default_min_text = docNode.createTextNode(num2str(inputArg4));
                default_min_node.appendChild(default_min_text);
                controlLinear_node.appendChild(default_min_node);
                default_max_node = docNode.createElement('default_max');
                default_max_text = docNode.createTextNode(num2str(inputArg5));
                default_max_node.appendChild(default_max_text);
                controlLinear_node.appendChild(default_max_node);
                filter_on_node = docNode.createElement('filter_on');
                filter_on_text = docNode.createTextNode('true');
                filter_on_node.appendChild(filter_on_text);
                controlLinear_node.appendChild(filter_on_node);
                use_steps_node = docNode.createElement('use_steps');
                use_steps_text = docNode.createTextNode('false');
                use_steps_node.appendChild(use_steps_text);
                controlLinear_node.appendChild(use_steps_node);
    
    % Write MAT Data to the OpenSim XML format
                x_nodes = docNode.createElement('x_nodes');
                for i=1:size(inputArg1,1)
                    node_1 = docNode.createElement('ControlLinearNode');
                            node_2 = docNode.createElement('t');
                            node_2.appendChild(docNode.createTextNode(sprintf('%f',inputArg1(i)+inputArg3))); %add_time + time_offset
                        node_1.appendChild(node_2);
                            node_3 = docNode.createElement('value');
                            node_3.appendChild(docNode.createTextNode(sprintf('%f',inputArg2(i)))); %add_value
                        node_1.appendChild(node_3);
                    x_nodes.appendChild(node_1);
                end
                controlLinear_node.appendChild(x_nodes);
                
                min_nodes = docNode.createElement('min_nodes');
                for i=1:size(inputArg1,1)
                    node_1 = docNode.createElement('ControlLinearNode');
                            node_2 = docNode.createElement('t');
                            node_2.appendChild(docNode.createTextNode(sprintf('%f',inputArg1(i)+inputArg3)));
                        node_1.appendChild(node_2);
                            node_3 = docNode.createElement('value');
                            node_3.appendChild(docNode.createTextNode(sprintf('%f',inputArg2(i))));
                        node_1.appendChild(node_3);
                    min_nodes.appendChild(node_1);
                end
                controlLinear_node.appendChild(min_nodes);
                
                max_nodes = docNode.createElement('max_nodes');
                for i=1:size(inputArg1,1)
                    node_1 = docNode.createElement('ControlLinearNode');
                            node_2 = docNode.createElement('t');
                            node_2.appendChild(docNode.createTextNode(sprintf('%f',inputArg1(i)+inputArg3)));
                        node_1.appendChild(node_2);
                            node_3 = docNode.createElement('value');
                            node_3.appendChild(docNode.createTextNode(sprintf('%f',inputArg2(i))));
                        node_1.appendChild(node_3);
                    max_nodes.appendChild(node_1);
                end
                controlLinear_node.appendChild(max_nodes);
                
                kp_node = docNode.createElement('kp');
                kp_node.appendChild(docNode.createTextNode('100'));
                controlLinear_node.appendChild(kp_node);
                kv_node = docNode.createElement('kv');
                kv_node.appendChild(docNode.createTextNode('100'));
                controlLinear_node.appendChild(kv_node);
                
    % Save the sample XML document.
    xmlFileName = ['lSimulink_output_controls','.xml'];
    xmlwrite(xmlFileName,docNode);
    edit(xmlFileName);

outputArg1 = true;
end
