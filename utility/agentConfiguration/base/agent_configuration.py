from abc import ABC, abstractmethod

class AgentConfiguration(ABC):
    
    @abstractmethod
    async def configure():
        pass